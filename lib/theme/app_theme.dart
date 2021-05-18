import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    appBarTheme: appBarTheme(),
    scaffoldBackgroundColor: kBackgroundColor,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    brightness: Brightness.dark,
    backgroundColor: kAppBarColor,
  );
}
