import 'package:dio/dio.dart';
import 'package:flutter_app_template/core/network/dio_interceptor.dart';

class DioFactory {
  final String _baseUrl;

  DioFactory(this._baseUrl);

  BaseOptions _createBaseOptions() => BaseOptions(
    baseUrl: _baseUrl,
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
    connectTimeout: const Duration(seconds: 60),
  );

  Dio create() =>
      Dio(_createBaseOptions())
        ..interceptors.addAll(<Interceptor>[DioInterceptor()]);
}
