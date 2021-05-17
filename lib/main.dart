import 'package:flutter/material.dart';

import 'package:chat_app/utils/app_routes.dart';

import 'screens/home_screen/home_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      title: "Chat App",
      theme: appTheme(),
      routes: appRoutes,
    );
  }
}
