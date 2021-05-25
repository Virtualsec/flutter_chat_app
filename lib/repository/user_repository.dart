import 'dart:developer';

import 'package:chat_app/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final firebaseDB = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final googleAuth = GoogleSignIn();

  Future signupUser(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    log('||----------Signup Process Started----------||');

    try {
      UserCredential authResult =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      firebaseDB.collection('users').doc(authResult.user.uid).set({
        'username': name,
        'email': email,
      });

      log(authResult.user.email);
      log(authResult.user.displayName);

      return authResult.user;
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text(e.message),
          backgroundColor: kPrimaryColor,
        ),
      );
    }
  }

  Future signinUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    log('||----------Signin Process Started----------||');

    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult.user;
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text(e.message),
          backgroundColor: kPrimaryColor,
        ),
      );
    }
  }

  Future googleAuthUser(BuildContext context) async {
    log('||----------GoogleAuth Process Started----------||');

    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await firebaseAuth.signInWithCredential(credential);

      firebaseDB.collection('users').doc(authResult.user.uid).set({
        'username': authResult.user.displayName,
        'email': authResult.user.email,
      });

      return authResult.user;
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text(e.message),
          backgroundColor: kPrimaryColor,
        ),
      );
    }
  }

  Future<void> signoutUser() async {
    await googleAuth.signOut();
    return firebaseAuth.signOut();
  }

  Future<bool> isUserSignin() async {
    var user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<User> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }
}
