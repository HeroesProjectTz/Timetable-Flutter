// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timetable/main.dart';
import 'package:timetable/screens/authentication/login_page.dart';
import 'package:timetable/screens/authentication/sign_up_page.dart';
import 'package:timetable/screens/homepage/homepage.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/authwrapper',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/signin',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/authwrapper',
      builder: (context, state) => const AuthenticationWrapper(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
