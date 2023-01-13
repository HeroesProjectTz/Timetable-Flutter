import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable/providers/authentication/authentication_provider.dart';
import 'package:timetable/services/firestore_database.dart';

final databaseProvider = FutureProvider<FirestoreDatabase?>((ref) async {
  final auth = await ref.read(authStateChangesProvider.future);

  final firebase = FirebaseFirestore.instance;

  // we only have a valid DB if the user is signed in
  if (auth != null) {
    return FirestoreDatabase(db: firebase, user: auth);
  }
  return null;
});
