import 'package:firebase_login/firebase_login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          FlatButton(
            onPressed: () {
              FirebaseLogin.signOut(context);
            },
            child: Text("Sign out"),
          )
        ],
      ),
    );
  }
}
