import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/screens/components/circle_icon_button.dart';
import 'package:firebase_login/screens/components/fail_dialog.dart';
import 'package:flutter/material.dart';

class LoginSocial extends StatefulWidget {
  const LoginSocial({
    Key? key,
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
          onPress: () async {
            await handleSignInWithKakao(context);
          },
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

  Future handleSignInWithKakao(BuildContext context) async {
    dynamic error = await _userRepository.signInWithKakao();
    if (error is String) {
      if (error.isNotEmpty)
        showDialog(
          context: context,
          builder: (context) => FailDialog(
            context: context,
            title: "Login Fail",
            message: error,
          ),
        );
    } else if (error is AuthCredential) {
      showDialogRequireLoginByGooogle(error);
    }
  }

  ///Return an [AuthCredential] or [Error]
  ///
  ///[AuthCredential] means user have to login with Facebook and connect session to [AuthCredential] of Google
  ///
  ///[Error] String is error triggered during handle.
  Future handleSignInWithGoogle(BuildContext context) async {
    dynamic error = await _userRepository.signInWithGoogle();
    if (error is String) {
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
    } else if (error is AuthCredential) {
      showDialogRequireLoginByFacebook(error);
    }
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

  ///Return an [AuthCredential] or [Error]
  ///
  ///[AuthCredential] means user have to login with Google and connect session to [AuthCredential] of Facebook
  ///
  ///[Error] String is error triggered during handle.
  Future handleSignInWithFacebook(BuildContext context) async {
    dynamic result = await _userRepository.signInWithFacebook();
    if (result is String) {
      String error = result;
      if (result.isNotEmpty)
        showDialog(
          context: context,
          builder: (context) => FailDialog(
            context: context,
            title: "Login fail",
            message: error,
          ),
          barrierDismissible: true,
        );
    } else if (result is AuthCredential) {
      showDialogRequireLoginByGooogle(result);
    }
  }

  ///Use for show dialog required login by Google
  ///
  ///[credential] is a login credential get from login Facebook or Apple
  void showDialogRequireLoginByGooogle(AuthCredential credential) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Please login by Gooogle"),
        content: Text(
            "Your account has been conect to Google account, please use login by Google feature."),
        actions: [
          FlatButton(
            child: Text("Login by Goole"),
            onPressed: () {
              _userRepository.signInWithGoogle(credential: credential);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  ///Use for show dialog required login by Facebook
  ///
  //////[credential] is a login credential get from login Google or Apple
  void showDialogRequireLoginByFacebook(AuthCredential credential) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Please login by Facebook"),
        content: Text(
            "Your account has been conect to Facebook account, please use login by Facebook feature."),
        actions: [
          FlatButton(
            child: Text("Login by Facebook"),
            onPressed: () {
              _userRepository.signInWithFacebook(credential: credential);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      barrierDismissible: false,
    );
  }
}
