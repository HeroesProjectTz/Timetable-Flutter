import 'package:timetable/providers/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable/screens/authentication/sign_in_page.dart';
import '../../common/bubble_loading_widget.dart';
import 'package:timetable/services/firestore_database.dart';

class CheckAuth extends ConsumerWidget {
  final Widget Function(FirestoreDatabase db) pageBuilder;

  const CheckAuth({
    Key? key,
    required this.pageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    final dbAsync = ref.watch(databaseProvider);
    return dbAsync.when(
        data: (db) {
          if (db != null) {
            return pageBuilder(db);
          } else {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   c.pushNamed('signIn');
            // });

            // This is stopping signin page interacture and shouldn't be used
            return Container();
          }
        },
        error: (err, st) {
          debugPrint("login failed. Error: $err, Stacktrace: $st");
          return SigninPage();
        },
        loading: () => const BubbleLoadingWidget());
  }
}
