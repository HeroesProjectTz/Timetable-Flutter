import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timetable/common/textfield_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextFieldWidget(
            texttFieldController: TextEditingController(),
            hintText: "Try to type"),
        Container(
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
                  debugPrint("touched seems to be working");

                  // ref.read(authenticationProvider).signOut();
                  // GoRouter.of(context).pushNamed('timetable');
                },
                child: const Center(child: Text('Homepage')))),
      ],
    ));
  }
}
