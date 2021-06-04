import 'package:firebase_login/screens/common_utils.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class VerifyEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Verify Email"),
      body: Body(),
    );
  }
}
