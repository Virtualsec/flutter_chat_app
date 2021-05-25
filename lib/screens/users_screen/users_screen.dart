import 'dart:developer';

import 'package:chat_app/screens/chat_screen/chat_screen.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  static String routeName = '/users';

  final firebaseDB = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  creatChatRoom(BuildContext context, email, username) {
    String myEmail = firebaseAuth.currentUser.email;
    String myUsername = firebaseAuth.currentUser.displayName;
    if (email == myEmail) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text('Cannot chat to self!'),
          backgroundColor: kPrimaryColor,
        ),
      );
    } else {
      String a = email.substring(0, email.indexOf('@'));
      String b = myEmail.substring(0, myEmail.indexOf('@'));

      String chatRoomID = getChatRoomId(a, b);

      List<String> users = [username, myUsername];

      Map<String, dynamic> chatRoomData = {
        'users': users,
        'chatRoomID': chatRoomID,
      };

      creatChatRoomFirebase(chatRoomID, chatRoomData);
      Navigator.of(context).pushNamed(
        ChatScreen.routeName,
        arguments: {
          'chatRoomID': chatRoomID,
          'username': username,
        },
      );
    }
  }

  creatChatRoomFirebase(String chatRoomID, chatRoomData) async {
    firebaseDB
        .collection('chat_rooms')
        .doc(chatRoomID)
        .set(chatRoomData)
        .catchError(
      (e) {
        log(e.toString());
      },
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: StreamBuilder(
        stream: firebaseDB
            .collection('users')
            .orderBy(
              'username',
              descending: false,
            )
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = streamSnapshot.data.docs;
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          onTap: () => creatChatRoom(
                            context,
                            docs[index]['email'].toString(),
                            docs[index]['username'],
                          ),
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundColor: kPrimaryColor,
                            child: Center(
                              child: Text(
                                '${docs[index]['username'][0]}'.toUpperCase(),
                                style: TextStyle(
                                  color: kWhiteTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            '${docs[index]['username']}'.toUpperCase(),
                            style: TextStyle(
                              color: kWhiteTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${docs[index]['email']}',
                            style: TextStyle(
                              color: kGreyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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
        },
      ),
    );
  }
}
