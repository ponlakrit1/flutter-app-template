import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/di/injector.dart';
import 'package:flutter_app_template/core/models/auth/user_profile_model.dart';
import 'package:flutter_app_template/core/services/auth_service.dart';

class HomeProvider extends ChangeNotifier {
  final AuthService _authService = injector<AuthService>();

  HomeProvider();

  UserProfileModel? profile;

  bool isLoading = false;

  Future<void> getProfile() async {
    try {
      isLoading = true;
      profile = await _authService.profile();

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
