import 'package:flutter/material.dart';

class SignUpHeader extends StatefulWidget {
  @override
  _SignUpHeaderState createState() => _SignUpHeaderState();
}

class _SignUpHeaderState extends State<SignUpHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome friend",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "Register an account to \nuse all feature felling good at all",
          style: TextStyle(
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
