import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/di/injector.dart';
import 'package:flutter_app_template/core/services/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService = injector<AuthService>();

  LoginProvider();

  bool isLoading = false;

  Future<bool> login(String username, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await _authService.login(username, password);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
