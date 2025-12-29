import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app_template/core/error/exceptions.dart';
import 'package:flutter_app_template/core/models/auth/user_auth_model.dart';
import 'package:flutter_app_template/core/utils/secure_storage_helper.dart';

class AuthService {
  final Dio dio;
  final SecureStorageHelper tokenStorage;

  AuthService({required this.dio, required this.tokenStorage});

  Future<UserAuthModel> login(String username, String password) async {
    final response = await dio.post(
      '/api/auth/login',
      data: {'username': username, 'password': password},
    );

    if (response.statusCode == HttpStatus.ok) {
      final userAuth = UserAuthModel.fromJson(response.data);

      await tokenStorage.saveTokens(
        accessToken: userAuth.accessToken,
        refreshToken: userAuth.refreshToken,
      );

      return userAuth;
    } else {
      throw ServerException();
    }
  }

  Future<void> logout() async {
    await tokenStorage.clear();
  }
}
