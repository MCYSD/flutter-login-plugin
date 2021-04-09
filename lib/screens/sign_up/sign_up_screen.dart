import 'package:flutter/material.dart';

import '../common_utils.dart';
import 'components/body.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Sign up"),
      body: Body(),
    );
  }
}
