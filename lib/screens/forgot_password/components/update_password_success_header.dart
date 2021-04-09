import 'package:flutter/material.dart';

import '../../common_utils.dart';

class UpdatePasswordSuccessHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Congratulation",
          style: TextStyle(
              color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        marginVerticalSmall,
        Text(
          "Your password had been updated",
          style: TextStyle(
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
