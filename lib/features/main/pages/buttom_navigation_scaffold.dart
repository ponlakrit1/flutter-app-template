import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_color.dart';
import 'package:flutter_app_template/features/home/pages/home_screen.dart';
import 'package:flutter_app_template/features/main/providers/bottom_nav_provider.dart';
import 'package:flutter_app_template/features/profile/pages/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ButtomNavigationScaffold extends StatelessWidget {
  static const String routeName = '/';

  const ButtomNavigationScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<BottomNavProvider>();
    // final location = GoRouterState.of(context).uri.toString();

    // if (location.startsWith(HomeScreen.routeName)) nav.setIndex(0);
    // if (location.startsWith(ProfileScreen.routeName)) nav.setIndex(1);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColor.neutral.shade300,
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: const Offset(0, 0),
            ),
          ],
          color: AppColor.neutral.shade50,
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColor.neutral.shade50,
          type: BottomNavigationBarType.fixed,
          currentIndex: nav.currentIndex,
          onTap: (index) {
            nav.setIndex(index);

            switch (index) {
              case 0:
                context.goNamed(HomeScreen.routeName);
                break;
              case 1:
                context.goNamed(ProfileScreen.routeName);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
