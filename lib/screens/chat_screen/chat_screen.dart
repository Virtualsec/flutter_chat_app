import 'dart:developer';

import 'package:chat_app/models/chat_messages.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static String routeName = '/chat';

  final firebaseDB = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  String msg;

  sendMessage(String chatRoomID, BuildContext context) {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      if (msg != null) {
        log(chatRoomID);
        Map<String, dynamic> chatMessageData = {
          "sendBy": firebaseAuth.currentUser.email,
          "msg": msg,
          'time': DateTime.now().millisecondsSinceEpoch,
        };
        log(chatMessageData.toString());
        firebaseDB
            .collection("chat_rooms")
            .doc(chatRoomID)
            .collection("chats")
            .add(chatMessageData)
            .catchError(
          (e) {
            print(e.toString());
          },
        );
        _formKey.currentState.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    log(data.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['username'],
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: firebaseDB
            .collection("chat_rooms")
            .doc(data['chatRoomID'])
            .collection("chats")
            .orderBy('time', descending: true)
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
                    reverse: true,
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final isMe = docs[index]['sendBy'] ==
                          firebaseAuth.currentUser.email;
                      return Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: isMe
                                    ? Radius.circular(8)
                                    : Radius.circular(2),
                                bottomRight: isMe
                                    ? Radius.circular(2)
                                    : Radius.circular(8),
                              ),
                              // borderRadius: BorderRadius.circular(4),
                              color: isMe
                                  ? kPrimaryColor
                                  : kSenderChatBackgroundColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${docs[index]['msg']}',
                                  style: TextStyle(
                                    color: kWhiteTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  color: kAppBarColor,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: kChatInputBackgroundColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            height: 46,
                            child: TextFormField(
                              style: TextStyle(
                                color: kWhiteTextColor,
                                fontSize: 18,
                              ),
                              maxLines: 3,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Type message',
                                hintStyle: TextStyle(
                                  color: kInputHintTextColor.withOpacity(0.5),
                                ),
                              ),
                              onChanged: (value) {
                                msg = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => sendMessage(data['chatRoomID'], context),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            height: 46,
                            width: 46,
                            child: Center(
                              child: Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
