import 'package:firebase_login/screens/size_config.dart';
import 'package:flutter/material.dart';

import '../../common_utils.dart';

class VerifyEmailHeader extends StatelessWidget {
  final String email;

  const VerifyEmailHeader({Key key, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        marginVerticalLong,
        Text.rich(
          TextSpan(
            text: "Please check you email \n",
            style: TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: email,
                style: TextStyle(color: Colors.red),
              ),
              TextSpan(
                text: "\nand click on the link to verify",
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: getProportionateScreenWidth(18)),
        ),
      ],
    );
  }
}
