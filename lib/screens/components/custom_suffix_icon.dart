import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  final String? icon;
  const CustomSuffixIcon({
    Key? key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: SvgPicture.asset(
    //     icon,
    //     package: "firebase_login",
    //     width: 18,
    //   ),
    // );
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
        child: SvgPicture.asset(
          icon ?? "",
          package: "firebase_login",
          width: 18,
        ));
  }
}
