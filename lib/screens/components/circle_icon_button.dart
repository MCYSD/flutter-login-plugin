import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleIconButton extends StatelessWidget {
  final String icon;
  final GestureTapCallback onPress;
  final Color backgroundColor;
  const CircleIconButton(
      {Key? key,
      required this.icon,
      required this.onPress,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      fillColor: backgroundColor,
      child: SvgPicture.asset(icon, package: "firebase_login"),
      padding: EdgeInsets.all(8),
      shape: CircleBorder(),
    );
  }
}
