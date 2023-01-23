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
      name: 'signin',
      path: '/signin',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      name: 'authwrapper',
      path: '/authwrapper',
      builder: (context, state) => const AuthenticationWrapper(),
    ),
    GoRoute(
      name: 'homepage',
      path: '/homepage',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
