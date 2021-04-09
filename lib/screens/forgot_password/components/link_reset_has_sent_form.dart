import 'package:firebase_login/screens/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../common_utils.dart';
import '../../size_config.dart';

class LinkResetHasSentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          marginVerticalLong,
          SizedBox(
            child: Lottie.asset("assets/animation/congrats.json",
                package: "firebase_login"),
            //width: getProportionateScreenWidth(100),
            //height: getProportionateScreenHeight(100),
          ),
          marginVerticalLong,
          DefaultButton(
            text: "Back to login page",
            onPress: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
