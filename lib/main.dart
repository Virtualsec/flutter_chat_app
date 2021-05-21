import 'package:chat_app/providers/auth_providers.dart';
import 'package:chat_app/screens/signin_screen/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SigninScreen.routeName,
        title: 'Chat App',
        theme: appTheme(),
        routes: appRoutes,
      ),
    );
  }
}
