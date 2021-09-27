import 'dart:async';

import 'package:firebase_login/firebase_login.dart';
import 'package:firebase_login/screens/login/components/login_social.dart';
import 'package:firebase_login_example/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              builder: (context) => FirebaseLogin.firebaseLoginScreen(
                  homeScreen: HomeScreen(),
                  loginSupports: [],
                  onLoginSuccess: (user) {
                    print("Login success: Username = ${user.displayName}");
                  }),
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
