import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grove/screens/error_screen.dart';
import 'package:grove/screens/home_screen.dart';
import 'package:grove/screens/login_screen.dart';

final router = GoRouter(
  initialLocation: '/login',
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Settings'),
        ),
      ),
    )
  ],
);
