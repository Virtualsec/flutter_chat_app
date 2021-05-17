import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    brightness: Brightness.dark,
  );
}
