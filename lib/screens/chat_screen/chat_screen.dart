import 'package:chat_app/models/chat_messages.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static String routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    final dummyData = demoChatMessages.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(left: 16),
          width: 46,
          child: CircleAvatar(
            backgroundColor: kPrimaryColor,
            child: Text(
              'KP',
              style: TextStyle(
                color: kWhiteTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        title: Text(
          "Kamlesh Prajapat",
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: dummyData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: dummyData[index].isSender
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: dummyData[index].isSender
                                ? Radius.circular(8)
                                : Radius.circular(2),
                            bottomRight: dummyData[index].isSender
                                ? Radius.circular(2)
                                : Radius.circular(8),
                          ),
                          // borderRadius: BorderRadius.circular(4),
                          color: dummyData[index].isSender
                              ? kPrimaryColor
                              : kSenderChatBackgroundColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${dummyData[index].text}',
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
                      child: TextField(
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
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
