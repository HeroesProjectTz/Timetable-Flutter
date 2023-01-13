import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timetable/models/database/user_model.dart';

class FirestoreDatabase {
  final FirebaseFirestore db;
  final User user;
  late final uid = user.uid;

  FirestoreDatabase({required this.db, required this.user});

  // ==== type-safe collection access helpers ====
  CollectionReference<UserModel> usersCollection() =>
      db.collection('users').withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromSnapshot(snapshot),
          toFirestore: (user, _) => user.toMap());
}
