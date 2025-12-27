import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app_template/core/di/injector.dart';
import 'package:flutter_app_template/core/utils/environment.dart';
import 'package:flutter_app_template/core/utils/secure_storage_helper.dart';

class DioInterceptor extends Interceptor {
  SecureStorageHelper tokenStorage = injector<SecureStorageHelper>();
  Environment env = injector<Environment>();

  DioInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? accessToken = await tokenStorage.getAccessToken();

    options.headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";

    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: env.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${tokenStorage.getRefreshToken()}',
          },
        ),
      );

      final refreshTokenResponse = await refreshDio.post('/api/auth/refresh');

      if (refreshTokenResponse.statusCode == HttpStatus.ok) {
        await tokenStorage.saveTokens(
          accessToken: refreshTokenResponse.data['access_token'],
          refreshToken: refreshTokenResponse.data['refresh_token'],
        );

        RequestOptions options = err.requestOptions;
        options.headers[HttpHeaders.authorizationHeader] =
            "Bearer ${refreshTokenResponse.data['access_token']}";

        Dio dio = injector<Dio>();

        try {
          final Response<dynamic> retryResponse = await dio.request(
            err.requestOptions.path,
            data: options.data,
            cancelToken: options.cancelToken,
            onReceiveProgress: options.onReceiveProgress,
            onSendProgress: options.onSendProgress,
            queryParameters: options.queryParameters,
          );
          handler.resolve(retryResponse);
        } on DioException catch (error) {
          handler.reject(error);
        }
      }
    } else if (err.response?.statusCode == HttpStatus.forbidden) {
      // Redirect login screen
      handler.reject(err);
    } else {
      handler.reject(err);
    }
  }
}
