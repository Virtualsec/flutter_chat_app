import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/bloc/signup_bloc/signup_bloc.dart';
import 'package:chat_app/bloc/signup_bloc/signup_event.dart';
import 'package:chat_app/bloc/signup_bloc/signup_state.dart';
import 'package:chat_app/screens/home_screen/home_screen.dart';
import 'package:chat_app/screens/signin_screen/signin_screen.dart';
import 'package:chat_app/theme/app_colors.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignupBloc(SignupInitState()),
        child: SignupBody(),
      ),
    );
  }
}

class SignupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    SignupBloc signupBloc = BlocProvider.of<SignupBloc>(context);

    String _userName;
    String _userEmail;
    String _userPassword;

    void submitData() {
      final isValid = _formKey.currentState.validate();
      if (isValid) {
        _formKey.currentState.save();
        signupBloc.add(
          SignupSubmitEvent(
            name: _userName,
            email: _userEmail,
            password: _userPassword,
            context: context,
          ),
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
            child: BlocListener<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state is SignupInitState) {
                } else if (state is SignupSuccessState) {
                  Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
                } else if (state is SignupLoadingState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                        ),
                      ),
                      backgroundColor: Colors.grey.withOpacity(0.2),
                    ),
                  );
                }
              },
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
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
                        signupBloc.add(SignupWithGoogleEvent(context));
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
                          Navigator.of(context)
                              .pushNamed(SigninScreen.routeName);
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
      ),
    );
  }
}
