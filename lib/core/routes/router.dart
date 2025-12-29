import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/di/injector.dart';
import 'package:flutter_app_template/core/services/auth_service.dart';
import 'package:flutter_app_template/features/auth/pages/login_screen.dart';
import 'package:flutter_app_template/features/auth/pages/splash_screen.dart';
import 'package:flutter_app_template/features/auth/providers/login_provider.dart';
import 'package:flutter_app_template/features/home/pages/home_screen.dart';
import 'package:flutter_app_template/features/home/providers/home_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: SplashScreen.routeName,
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      name: SplashScreen.routeName,
      path: SplashScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return ChangeNotifierProvider(
          create: (_) => LoginProvider(authService: injector<AuthService>()),
          child: const LoginScreen(),
        );
      },
    ),
    GoRoute(
      name: HomeScreen.routeName,
      path: HomeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return ChangeNotifierProvider(
          create: (_) =>
              HomeProvider(authService: injector<AuthService>())..getProfile(),
          child: const HomeScreen(),
        );
      },
    ),
  ],
);
