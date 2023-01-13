import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:timetable/common/bubble_loading_widget.dart';
import 'package:timetable/providers/authentication/authentication_provider.dart';
import 'package:timetable/utils/colours.dart';
import 'package:timetable/utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCxWXaxOZUp0atDiFrbOSRyTBaTi7CnGDY",
          authDomain: "timetable-4867a.firebaseapp.com",
          projectId: "timetable-4867a",
          storageBucket: "timetable-4867a.appspot.com",
          messagingSenderId: "1041340480197",
          appId: "1:1041340480197:web:8b524bb1f8f75bd1778eac",
          measurementId: "G-38XEWZ2ETP"),
    );
  }
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, child!),
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
      title: 'TimeTable',
      theme: ThemeData(
        primaryColor: const Color(0xffD9D9D9),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: greyColor02,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            unselectedIconTheme: const IconThemeData(
              color: greyColor02,
              size: 15,
            ),
            selectedIconTheme: const IconThemeData(
              color: greyColor02,
              size: 15,
            )),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: Colors.black,
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xffD9D9D9), width: 0.0),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xffD9D9D9), width: 1.0),
              borderRadius: BorderRadius.circular(8)),
          fillColor: const Color(0xffD9D9D9),
          filled: true,
          isDense: true,
          focusColor: const Color(0xffD9D9D9),
          // focusColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(18),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        backgroundColor: const Color(0xffF1FAEE),
      ),
    );
  }
}

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    return authState.when(
        data: (data) {
          if (data != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              goRouter.go('/homepage');
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              goRouter.go('/signin');
            });
          }
          return Container(color: Colors.white);
        },
        loading: () => const BubbleLoadingWidget(),
        error: (e, trace) => Text(e.toString()));
  }
}
