import 'dart:developer';

import 'package:chat_app/providers/auth_providers.dart';
import 'package:chat_app/screens/home_screen/home_screen.dart';
import 'package:chat_app/screens/signin_screen/signin_screen.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return SignupBody();
          }
        },
      ),
    );
  }
}

class SignupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    String _userName;
    String _userEmail;
    String _userPassword;

    void submitData() {
      final isValid = _formKey.currentState.validate();
      if (isValid) {
        _formKey.currentState.save();
        authProvider.signup(
          _userName.trim(),
          _userEmail.trim(),
          _userPassword.trim(),
        );

        log(_userName);
        log(_userEmail);
        log(_userPassword);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 56),
                  Text(
                    'Get started,',
                    style: TextStyle(
                      color: kWhiteTextColor,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 64),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                      color: kInputBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: double.infinity,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter you Name';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: kWhiteTextColor,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: kInputHintTextColor,
                        ),
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                      color: kInputBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: double.infinity,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Enter a Valid Email ID';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: kWhiteTextColor,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Email ID',
                        hintStyle: TextStyle(
                          color: kInputHintTextColor,
                        ),
                      ),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                      color: kInputBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: double.infinity,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Must be at least 6 characters long.';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: kWhiteTextColor,
                        fontSize: 24,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: kInputHintTextColor,
                        ),
                      ),
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: submitData,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: kWhiteTextColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Or, sign up with ',
                          style: TextStyle(
                            color: kWhiteTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      authProvider.googleLogin();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Google',
                          style: TextStyle(
                            color: kBlackTextColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(SigninScreen.routeName);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: kWhiteTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
