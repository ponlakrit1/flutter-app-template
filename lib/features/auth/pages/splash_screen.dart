import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/di/injector.dart';
import 'package:flutter_app_template/core/theme/app_color.dart';
import 'package:flutter_app_template/core/utils/secure_storage_helper.dart';
import 'package:flutter_app_template/features/auth/pages/login_screen.dart';
import 'package:flutter_app_template/features/home/pages/home_screen.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    final SecureStorageHelper tokenStorage = injector<SecureStorageHelper>();
    final token = await tokenStorage.hasValidToken();

    if (mounted) {
      if (token) {
        context.pushReplacementNamed(HomeScreen.routeName);
      } else {
        context.pushReplacementNamed(LoginScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primary,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
