import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:go_router/go_router.dart';

class Authentication {
  // For Authentication related functions you need an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();

  // Now This Class Contains 3 Functions currently
  // 1. signInWithGoogle
  // 2. signOut
  // 3. signInWithEmailAndPassword
  // 4. signInWithFacebook

  //  SigIn the user using Email and Password
  Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        GoRouter.of(context).canPop()
            ? GoRouter.of(context).pop()
            : GoRouter.of(context).pushNamed('homepage');
      });
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  // SignUp the user using Email and Password
  Future signUpWithEmailAndPassword(String fullName, String email,
      String password, BuildContext context) async {
    try {
      _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        GoRouter.of(context).pushNamed('homepage');
        value.user!.updateDisplayName(fullName);
      });
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text('Error Occured'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text("OK"))
                  ]));
    } catch (e) {
      if (e == 'email-already-in-use') {
        debugPrint('Email already in use.');
      } else {
        debugPrint('Error: $e');
      }
    }
  }

  //  SignIn the user Google
  Future signInWithGoogle(BuildContext context) async {
    if (kIsWeb) {
      // running on the web!

      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      await _auth.signInWithPopup(googleProvider);
      GoRouter.of(context).pushNamed('homepage');

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    } else {
      // NOT running on the web! You can check for additional platforms here.
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        await _auth.signInWithCredential(credential);

        GoRouter.of(context).pushNamed('homepage');
      } on FirebaseAuthException catch (e) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error Occured'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("OK"))
            ],
          ),
        );
      }
    }
  }

  // Current userName
  String getCurrentUserFullName() {
    String fullName = _auth.currentUser?.displayName.toString() ?? '';
    return fullName;
  }

  // Current userName
  String getCurrentUserUID() {
    String uid = _auth.currentUser?.uid.toString() ?? 'null';
    return uid;
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  bool isLoggedIn() {
    final userUID = _auth.currentUser?.uid ?? '';
    bool userIsLoggedIn = userUID == '' ? false : true;
    return userIsLoggedIn;
  }
  // Function to address final final complete

  uerSessionActivated(String fullName, String email, String userId) {
    // Todo maybe create and load Firebase user here
  }
}
