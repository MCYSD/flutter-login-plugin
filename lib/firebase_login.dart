import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/screens/firebase_login_screen.dart';
import 'package:firebase_login/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirebaseLogin {
  static const MethodChannel _channel = const MethodChannel('firebase_login');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Widget get getLoginScreen {
    return LoginScreen();
  }

  static Widget? _homeScreen;
  static Widget? get homeScreen => _homeScreen;
  static String? uid;
  static User? userInfo;

  static Widget firebaseLoginScreen(
      {required Widget homeScreen,
      required void Function(User) onLoginSuccess}) {
    _homeScreen = homeScreen;
    return FirebaseLoginScreen(
      homeScreen: homeScreen,
      onLoginSuccess: onLoginSuccess,
    );
  }

  static void signOut(BuildContext context) async {
    final UserRepository _userRepository = UserRepository();
    try {
      await _userRepository.signOut();
    } catch (e) {
      print(e);
    }
  }
}
