import 'package:firebase_login/screens/login/components/login_header.dart';
import 'package:firebase_login/screens/login/components/sign_in_form.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'login_social.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginHeader(),
            SizedBox(
              height: getProportionateScreenHeight(60),
            ),
            SignInForm(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            LoginSocial()
          ],
        ),
      ),
    );
  }
}
