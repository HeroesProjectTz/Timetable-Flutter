// private navigators
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
      const storage = FlutterSecureStorage();
      final isLoggedIn = authRepo.isLoggedIn();
      if (isLoggedIn) {
        return state.location;
      } else if (!isLoggedIn) {
        if (state.location != '') {
          performingSecureStorage() async {
            debugPrint('Current state location: ${state.location}');
            if (state.location == '/signin') {
              debugPrint(
                  "Not saving routing location because current route is signin");
            } else if (state.location == '/signup') {
              debugPrint(
                  "Not saving routing location because current route is signup");
            } else {
              debugPrint(
                  "doesnt contain signin or signup. Deleting current redirectRoute and saving new one.");
              await storage.delete(key: 'redirectRoute');
              debugPrint('just deleted previous redirect route location');
              await storage.write(key: 'redirectRoute', value: state.location);
              debugPrint("just wrote a new redirect route location");
            }
          }

          performingSecureStorage();
        }
        return '/signin';
      }
      return null;
    },
    routes: [
      GoRoute(
          name: 'signin',
          path: '/signin',
          builder: (context, state) {
            return const SigninPage();
          }),
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
