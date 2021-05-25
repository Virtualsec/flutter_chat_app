import 'dart:developer';

import 'package:chat_app/screens/chat_screen/chat_screen.dart';
import 'package:chat_app/screens/users_screen/users_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/bloc/home_bloc/home_bloc.dart';
import 'package:chat_app/bloc/home_bloc/home_event.dart';
import 'package:chat_app/bloc/home_bloc/home_state.dart';
import 'package:chat_app/screens/signin_screen/signin_screen.dart';
import 'package:chat_app/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';

  final User user;
  HomeScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(LogoutInitState()),
      child: HomeBody(user: user),
    );
  }
}

class HomeBody extends StatelessWidget {
  final User user;
  HomeBody({this.user});

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    final firebaseDB = FirebaseFirestore.instance;
    final firebaseAuth = FirebaseAuth.instance;

    String myUsername = firebaseAuth.currentUser.displayName;

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Navigator.of(context).popAndPushNamed(SigninScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Chat App',
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.person_add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(UsersScreen.routeName);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                homeBloc.add(LogoutEvent());
              },
            ),
          ],
        ),
        body: StreamBuilder(
            stream: firebaseDB
                .collection('chat_rooms')
                .where('users', arrayContains: myUsername)
                .snapshots(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final docs = streamSnapshot.data.docs;
              return docs.length == 0
                  ? Center(
                      child: Text(
                        'No Chats Found!',
                        style: TextStyle(color: kWhiteTextColor),
                      ),
                    )
                  : SafeArea(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        ChatScreen.routeName,
                                        arguments: {
                                          'chatRoomID': docs[index]
                                              ['chatRoomID'],
                                          'username': myUsername !=
                                                  '${docs[index]['users'][0]}'
                                              ? '${docs[index]['users'][0]}'
                                              : '${docs[index]['users'][1]}',
                                        },
                                      );
                                    },
                                    leading: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: kPrimaryColor,
                                      child: Center(
                                        child: Text(
                                          myUsername !=
                                                  '${docs[index]['users'][0]}'
                                              ? '${docs[index]['users'][0][0]}'
                                                  .toUpperCase()
                                              : '${docs[index]['users'][1][0]}'
                                                  .toUpperCase(),
                                          style: TextStyle(
                                            color: kWhiteTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      myUsername != '${docs[index]['users'][0]}'
                                          ? '${docs[index]['users'][0]}'
                                          : '${docs[index]['users'][1]}',
                                      style: TextStyle(
                                        color: kWhiteTextColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
