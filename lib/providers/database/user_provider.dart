import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable/providers/database/database_provider.dart';

import '../../models/database/user_model.dart';

final userProvider =
    StreamProvider.autoDispose.family<UserModel, String>((ref, userId) async* {
  final db = await ref.watch(databaseProvider.future);
});
