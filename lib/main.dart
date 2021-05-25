import 'package:chat_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/bloc/auth_bloc/auth_event.dart';
import 'package:chat_app/bloc/auth_bloc/auth_state.dart';
import 'package:chat_app/screens/landing_screen/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/utils/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: appTheme(),
      routes: appRoutes,
      home: BlocProvider(
        create: (context) => AuthBloc(AuthInitState())..add(AppInitEvent()),
        child: LandingScreen(),
      ),
    );
  }
}
