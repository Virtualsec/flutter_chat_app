import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat App",
        ),
      ),
      body: Center(
        child: Container(
          child: Text("Welcome to Chat App"),
        ),
      ),
    );
  }
}
