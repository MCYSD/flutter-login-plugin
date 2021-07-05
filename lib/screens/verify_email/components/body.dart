import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/screens/constants.dart';
import 'package:firebase_login/screens/verify_email/components/verify_email_body.dart';
import 'package:firebase_login/screens/verify_email/components/verify_email_header.dart';
import 'package:flutter/material.dart';

import '../../common_utils.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserRepository _userRepository = UserRepository();
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = _userRepository.getUserInfo();
    _userRepository.verifyEmail();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkVerifyStatus();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: phoneMaxWidth),
      child: Column(
        children: [
          VerifyEmailHeader(
            email: user?.email ?? "",
          ),
          marginVerticalLong,
          VerifyEmailBody(),
        ],
      ),
    );
  }

  Future<void> checkVerifyStatus() async {
    user = _userRepository.getUserInfo();
    await user?.reload();

    if (user?.emailVerified ?? true) {
      timer?.cancel();
    }
  }
}
