// private navigators
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timetable/providers/authentication/authentication_provider.dart';
import 'package:timetable/screens/authentication/sign_in_page.dart';
import 'package:timetable/screens/authentication/sign_up_page.dart';
import 'package:timetable/screens/homepage/homepage.dart';
import 'package:timetable/screens/timetable/timetable.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  var authRepo = ref.watch(authenticationProvider);
  return GoRouter(
    initialLocation: '/timetable',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepo.isLoggedIn();
      if (isLoggedIn) {
        return state.location;
      } else if (!isLoggedIn) {
        String redirectTo = state.location;
        return context
            .namedLocation('signin', params: {'redirectTo': redirectTo});
      }
      return null;
    },
    routes: [
      GoRoute(
        name: 'signin',
        path: '/signin',
        builder: (context, state) {
          final redirectToValue = state.params['redirectTo'];
          return SigninPage(
            redirectTo: redirectToValue,
          );
        },
      ),
      GoRoute(
        name: 'signup',
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        name: 'timetable',
        path: '/timetable',
        builder: (context, state) => const TimetablePage(),
      ),
      GoRoute(
        name: 'homepage',
        path: '/homepage',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
});
