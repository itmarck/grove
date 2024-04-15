import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grove/screens/error_screen.dart';
import 'package:grove/screens/home_screen.dart';
import 'package:grove/screens/login_screen.dart';

class Routes {
  static String get home => '/home';
  static String get login => '/login';
  static String get settings => '/settings';
}

final router = GoRouter(
  /// Home screen as a default value to avoid issues with the landing
  /// page in the future.
  initialLocation: Routes.home,

  /// Handle the protected routes.
  redirect: (context, state) async {
    return null;
  },

  /// Definition of application routes.
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Settings'),
        ),
      ),
    )
  ],
  errorBuilder: (context, state) => const ErrorScreen(),
);
