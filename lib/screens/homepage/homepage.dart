import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
            child: const Center(child: Text('Homepage'))));
  }
}
