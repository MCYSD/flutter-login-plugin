import 'package:firebase_login/provider/ForgotPasswordModel.dart';
import 'package:firebase_login/screens/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordModel(),
      child: Scaffold(
        appBar: buildAppBar("Forgot password"),
        body: Body(),
      ),
    );
  }
}
