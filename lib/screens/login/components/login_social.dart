import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/screens/components/circle_icon_button.dart';
import 'package:firebase_login/screens/components/fail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSocial extends StatefulWidget {
  const LoginSocial({
    Key key,
  }) : super(key: key);

  @override
  _LoginSocialState createState() => _LoginSocialState();
}

class _LoginSocialState extends State<LoginSocial> {
  UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleIconButton(
          backgroundColor: Colors.yellow,
          icon: "assets/icons/kakao-icon.svg",
          onPress: () {},
        ),
        CircleIconButton(
          icon: "assets/icons/google-icon.svg",
          onPress: () async {
            await handleSignInWithGoogle(context);
          },
        ),
        CircleIconButton(
          icon: "assets/icons/facebook-2.svg",
          onPress: () async {
            await handleSignInWithFacebook(context);
          },
        ),
        CircleIconButton(
          icon: "assets/icons/Apple.svg",
          backgroundColor: Colors.red,
          onPress: () async {
            await handleSignInWithApple(context);
          },
        ),
      ],
    );
  }

  Future handleSignInWithGoogle(BuildContext context) async {
    String error = await _userRepository.signInWithGoogle();
    if (error.isNotEmpty)
      showDialog(
        context: context,
        builder: (context) => FailDialog(
          context: context,
          title: "Login fail",
          message: error,
        ),
        barrierDismissible: true,
      );
  }

  Future handleSignInWithApple(BuildContext context) async {
    String error = await _userRepository.signInWithApple();
    if (error.isNotEmpty)
      showDialog(
        context: context,
        builder: (context) => FailDialog(
          context: context,
          title: "Login fail",
          message: error,
        ),
        barrierDismissible: true,
      );
  }

  Future handleSignInWithFacebook(BuildContext context) async {
    String error = await _userRepository.signInWithFacebook();
    if (error.isNotEmpty)
      showDialog(
        context: context,
        builder: (context) => FailDialog(
          context: context,
          title: "Login fail",
          message: error,
        ),
        barrierDismissible: true,
      );
  }
}
