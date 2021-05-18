import 'package:chat_app/screens/chat_screen/chat_screen.dart';
import 'package:chat_app/screens/home_screen/home_screen.dart';
import 'package:chat_app/screens/landing_screen/landing_screen.dart';
import 'package:chat_app/screens/signin_screen/signin_screen.dart';
import 'package:chat_app/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  LandingScreen.routeName: (context) => LandingScreen(),
  SigninScreen.routeName: (context) => SigninScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
};
