import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/services/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService authService;

  LoginProvider({required this.authService});

  bool isLoading = false;

  Future<bool> login(String username, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await authService.login(username, password);

      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
