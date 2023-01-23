import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timetable/providers/authentication/authentication_provider.dart';
import 'package:go_router/go_router.dart';

class TimetablePage extends ConsumerStatefulWidget {
  const TimetablePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimetablePageState();
}

class _TimetablePageState extends ConsumerState<TimetablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.blue,
            height: ResponsiveValue(
              context,
              defaultValue: 60.0,
              valueWhen: const [
                Condition.smallerThan(
                  name: MOBILE,
                  value: 80.0,
                ),
                Condition.largerThan(
                  name: TABLET,
                  value: 200.0,
                )
              ],
            ).value,
            child: InkWell(
                onTap: () {
                  ref.read(authenticationProvider).signOut();
                  GoRouter.of(context).pushNamed('TimetablePage');
                },
                child: const Center(child: Text('TimetablePage')))));
  }
}
