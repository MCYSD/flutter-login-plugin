import 'dart:async';

import 'package:firebase_login/firebase_login.dart';
import 'package:firebase_login_example/home_screen.dart';
import 'package:flutter/material.dart';

class SplashSreen extends StatefulWidget {
  @override
  _SplashSreenState createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashSreen> {
  int _count = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      _count++;
      if (_count == 2) {
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FirebaseLogin.firebaseLoginScreen(HomeScreen()),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(child: Text("Hello, splash screen here")),
      ),
    );
  }
}
