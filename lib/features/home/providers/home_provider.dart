import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/models/auth/user_profile_model.dart';
import 'package:flutter_app_template/core/services/auth_service.dart';

class HomeProvider extends ChangeNotifier {
  final AuthService authService;

  HomeProvider({required this.authService});

  UserProfileModel? profile;

  bool isLoading = false;

  Future<void> getProfile() async {
    try {
      isLoading = true;
      profile = await authService.profile();

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
