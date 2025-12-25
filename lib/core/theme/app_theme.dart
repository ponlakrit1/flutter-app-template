import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_color.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.neutral.shade100,
      primarySwatch: AppColor.primary,
    );
  }
}
