import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_example/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:kakao_flutter_sdk/all.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoContext.clientId = "5ec6bccfb97bbcc2672bfd22efe0b0af";
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashSreen();
  }
}
