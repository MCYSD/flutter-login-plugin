import 'package:flutter/material.dart';

import '../../common_utils.dart';

class SetNewPasswordHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "This is the last time",
          style: TextStyle(
              color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        marginVerticalSmall,
        Text(
          "Enter your password and never foget it, plzzzz",
          style: TextStyle(
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
