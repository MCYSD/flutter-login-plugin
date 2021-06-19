import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/screens/wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseLoginScreen extends StatelessWidget {
  final Widget homeScreen;
  final void Function(User) onLoginSuccess;
  const FirebaseLoginScreen(
      {Key? key, required this.homeScreen, required this.onLoginSuccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: UserRepository().user,
      initialData: null,
      child: WrapperScreen(
        onLoginSuccess: onLoginSuccess,
        homeScreen: homeScreen,
      ),
    );
  }
}
