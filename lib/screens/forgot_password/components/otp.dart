import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class OTP extends StatelessWidget {
  final Color borderColor;
  final Color focusBorderColor;
  final TextEditingController controller;
  final Function(String) onChange;
  final Function(String?) onSaved;
  final FocusNode focusNode;
  const OTP({
    Key? key,
    this.borderColor = Colors.grey,
    this.focusBorderColor = kPrimaryColor,
    required this.controller,
    required this.onChange,
    required this.onSaved,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      //alignment: Alignment.center,
      child: TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          focusNode: focusNode,
          decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(bottom: 20),
            isDense: true,
            fillColor: Colors.yellow,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                borderSide: BorderSide(color: borderColor)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              borderSide: BorderSide(color: focusBorderColor),
            ),
            hintText: ".",
          ),
          onChanged: onChange,
          onSaved: onSaved),
    );
  }
}
