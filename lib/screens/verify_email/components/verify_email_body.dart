import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/screens/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../common_utils.dart';
import '../../size_config.dart';

class VerifyEmailBody extends StatelessWidget {
  UserRepository _userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          marginVerticalLong,
          SizedBox(
            child: Lottie.asset("assets/animation/send_email.json",
                package: "firebase_login",
                width: getProportionateScreenWidth(200),
                height: getProportionateScreenHeight(200)),
          ),
          marginVerticalLong,
          DefaultButton(
            text: "Back To Login",
            onPress: () {
              _userRepository.signOut();
            },
          )
        ],
      ),
    );
  }
}
