import 'package:firebase_login/screens/common_utils.dart';
import 'package:flutter/material.dart';

class ForgotPasswordHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Tell me you email",
          style: TextStyle(
              color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        marginVerticalSmall,
        Text(
          "I will give you confirm email for reset password",
          style: TextStyle(
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
