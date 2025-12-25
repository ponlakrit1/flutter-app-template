import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/auth/login/login_screen.dart';
import 'package:flutter_app_template/features/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: LoginScreen.routeName,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      name: HomeScreen.routeName,
      path: HomeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
);
