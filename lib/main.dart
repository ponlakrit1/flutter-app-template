import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/di/injector.dart';
import 'package:flutter_app_template/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = injector<GoRouter>();

    return MaterialApp.router(
      title: 'Flutter App Template',
      theme: AppTheme.defaultTheme,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
