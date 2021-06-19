import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/screens/login/login_screen.dart';
import 'package:firebase_login/screens/verify_email/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase_login.dart';

class WrapperScreen extends StatelessWidget {
  final Widget homeScreen;
  final void Function(User) onLoginSuccess;

  const WrapperScreen(
      {Key? key, required this.homeScreen, required this.onLoginSuccess})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      FirebaseLogin.uid = "";
      return LoginScreen();
    } else {
      FirebaseLogin.uid = user.uid;
      FirebaseLogin.userInfo = user;
      onLoginSuccess.call(user);
      if (user.emailVerified == false) {
        return VerifyEmailScreen();
      }
      return homeScreen;
    }
  }
}
