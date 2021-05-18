import 'package:chat_app/screens/chat_screen/chat_screen.dart';
import 'package:chat_app/theme/app_colors.dart';
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add_alt_1_rounded,
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
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(ChatScreen.routeName);
                      },
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundColor: kPrimaryColor,
                        child: Center(
                          child: Text(
                            'KP',
                            style: TextStyle(
                              color: kWhiteTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        'Kamlesh Prajapat',
                        style: TextStyle(
                          color: kWhiteTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Hey there',
                        style: TextStyle(
                          color: kGreyTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '11:45 AM',
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
            )
          ],
        ),
      ),
    );
  }
}
