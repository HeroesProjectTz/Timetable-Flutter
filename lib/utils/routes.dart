// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timetable/screens/homepage/homepage.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/homepage',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/homepage',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
