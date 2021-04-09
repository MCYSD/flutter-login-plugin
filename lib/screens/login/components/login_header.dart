import 'package:flutter/material.dart';

import '../../size_config.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(
              color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Text(
          "Sign in with your email and password\nor continue with social media",
          style: TextStyle(
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
