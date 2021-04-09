import 'package:firebase_login/screens/common_utils.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';
import 'components/body.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: buildAppBar("Login"),
      body: Body(),
    );
  }
}
