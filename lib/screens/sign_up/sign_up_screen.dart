import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../common_utils.dart';
import '../constants.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return kIsWeb ? Row(children: [Spacer(), Body(), Spacer()]) : Body();
        },
      ),
    );
  }
}
