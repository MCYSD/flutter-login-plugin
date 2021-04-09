import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase_login.dart';

class WrapperScreen extends StatelessWidget {
  final Widget homeScreen;

  const WrapperScreen({Key key, @required this.homeScreen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      FirebaseLogin.uid = "";
      return LoginScreen();
    } else {
      FirebaseLogin.uid = user.uid;
      return homeScreen;
    }
  }
}
