import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/di/injector.dart';
import 'package:flutter_app_template/core/utils/secure_storage_helper.dart';

class LoginProvider extends ChangeNotifier {
  SecureStorageHelper tokenStorage = injector<SecureStorageHelper>();

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  LoginProvider() {
    checkLogin();
  }

  Future<void> checkLogin() async {
    final token = await tokenStorage.getAccessToken();
    _isAuthenticated = token != null;
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    await tokenStorage.clear();
    notifyListeners();
  }
}
