import 'package:flutter/material.dart';

import '../../common_utils.dart';

class EnterVefiryCodeHeader extends StatelessWidget {
  final String email;

  const EnterVefiryCodeHeader({Key key, @required this.email})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Check your messeage",
          style: TextStyle(
              color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        marginVerticalSmall,
        Text(
          "A reset code has been sent to $email",
          style: TextStyle(
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
