import 'package:chat_app/screens/home_screen/home_screen.dart';
import 'package:chat_app/screens/signup_screen/signup_screen.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  static String routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 56),
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    color: kWhiteTextColor,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 64),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    color: kInputBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 56,
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(
                      color: kWhiteTextColor,
                      fontSize: 24,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Email ID',
                      hintStyle: TextStyle(
                        color: kInputHintTextColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    color: kInputBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 56,
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(
                      color: kWhiteTextColor,
                      fontSize: 24,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: kInputHintTextColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreen.routeName, (_) => false);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: kWhiteTextColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Or, sign in with ',
                        style: TextStyle(
                          color: kWhiteTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  // onTap: () {
                  //   Navigator.of(context).pushNamed(SignupScreen.routeName);
                  // },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Google',
                        style: TextStyle(
                          color: kBlackTextColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignupScreen.routeName);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          color: kWhiteTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
