import 'package:firebase_login/screens/constants.dart';
import 'package:firebase_login/screens/sign_up/components/sign_up_form.dart';
import 'package:firebase_login/screens/sign_up/components/sign_up_header.dart';
import 'package:flutter/material.dart';
import '../../common_utils.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: phoneMaxWidth),
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SignUpHeader(),
              marginVerticalLong,
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
