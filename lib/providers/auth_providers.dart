import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final googleSigin = GoogleSignIn();

  User _user;

  User get user => _user;

  Future signin(String email, String password) async {
    UserCredential authResult =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    _user = authResult.user;
    notifyListeners();
  }

  Future signup(String username, String email, String password) async {
    UserCredential authResult = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authResult.user.uid)
        .set(
      {
        'username': username,
        'email': email,
      },
    );
    _user = authResult.user;
    notifyListeners();
  }

  Future googleLogin() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _user = userCredential.user;

      await FirebaseFirestore.instance.collection('users').doc(_user.uid).set(
        {
          'username': _user.displayName,
          'email': _user.email,
        },
      );
    } catch (e) {
      log(e);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    return FirebaseAuth.instance.signOut();
  }
}
