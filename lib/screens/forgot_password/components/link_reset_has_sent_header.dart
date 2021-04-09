import 'package:firebase_login/provider/ForgotPasswordModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_utils.dart';

class LinkResetHasSentHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordModel>(
      builder: (context, forgotPasswordModel, child) {
        return Column(
          children: [
            Text(
              "Reset link has sent",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
            marginVerticalSmall,
            Text.rich(
              TextSpan(
                text: "An reset link hast send to email: ",
                children: [
                  TextSpan(
                      text: forgotPasswordModel.getEmail,
                      style: TextStyle(color: Colors.red)),
                  TextSpan(text: "\nFollow the link to reset your password.")
                ],
              ),
              textAlign: TextAlign.center,
            )
          ],
        );
      },
    );
  }
}
