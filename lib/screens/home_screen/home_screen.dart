import 'dart:developer';

import 'package:chat_app/providers/auth_providers.dart';
import 'package:chat_app/screens/chat_screen/chat_screen.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    var _userId = auth.currentUser.uid;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Chat App',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ChatScreen.routeName);
                          },
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
                            '${docs[index]['username']}',
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
                          // trailing: Text(
                          //   '11:45 AM',
                          //   style: TextStyle(
                          //     color: kGreyTextColor,
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
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
