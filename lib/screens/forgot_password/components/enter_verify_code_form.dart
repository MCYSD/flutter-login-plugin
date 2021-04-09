import 'dart:async';

import 'package:firebase_login/provider/ForgotPasswordModel.dart';
import 'package:firebase_login/screens/common_utils.dart';
import 'package:firebase_login/screens/components/default_button.dart';
import 'package:firebase_login/screens/constants.dart';
import 'package:firebase_login/screens/forgot_password/components/otp.dart';
import 'package:firebase_login/screens/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterVerifyCodeForm extends StatefulWidget {
  @override
  _EnterVerifyCodeFormState createState() => _EnterVerifyCodeFormState();
}

class _EnterVerifyCodeFormState extends State<EnterVerifyCodeForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _otp1 = TextEditingController();

  final TextEditingController _otp2 = TextEditingController();

  final TextEditingController _otp3 = TextEditingController();

  final TextEditingController _otp4 = TextEditingController();

  final TextEditingController _otp5 = TextEditingController();

  final TextEditingController _otp6 = TextEditingController();
  int resentRemainTime = 60;

  FocusNode _focusNode1,
      _focusNode2,
      _focusNode3,
      _focusNode4,
      _focusNode5,
      _focusNode6;

  @override
  void initState() {
    initFocusNode();
    runResendTimer();
    super.initState();
  }

  @override
  void dispose() {
    disposeFocusNode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              marginVerticalNormal,
              buildOTPRow(),
              marginVerticalLong,
              DefaultButton(
                text: "Verify",
                onPress: () {
                  if (_otp1.text.isNotEmpty &&
                      _otp2.text.isNotEmpty &&
                      _otp3.text.isNotEmpty &&
                      _otp4.text.isNotEmpty &&
                      _otp5.text.isNotEmpty &&
                      _otp6.text.isNotEmpty) {
                    Provider.of<ForgotPasswordModel>(context, listen: false)
                        .setFormDisplay(
                            ForgotPasswordModel.SET_NEW_PASSWORD_FORM);
                  }
                },
              ),
              marginVerticalLong,
              Text("Didn't get verify code?"),
              marginVerticalSmall,
              SizedBox(
                height: getProportionateScreenHeight(60),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: resentRemainTime == 0 ? kPrimaryColor : Colors.grey,
                    onPressed: () {
                      if (resentRemainTime == 0) {
                        runResendTimer();
                        setState(() {
                          resentRemainTime = 60;
                        });
                      }
                    },
                    child: Text(
                      resentRemainTime == 0
                          ? "Resend"
                          : "Re-send after $resentRemainTime seconds",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ));
  }

  Row buildOTPRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OTP(
          controller: _otp1,
          focusNode: _focusNode1,
          onChange: (value) {
            if (value.isNotEmpty) _focusNode2.requestFocus();
          },
          onSaved: (newValue) {},
        ),
        OTP(
          controller: _otp2,
          focusNode: _focusNode2,
          onChange: (value) {
            if (value.isNotEmpty)
              _focusNode3.requestFocus();
            else
              _focusNode1.requestFocus();
          },
          onSaved: (newValue) {},
        ),
        OTP(
          controller: _otp3,
          focusNode: _focusNode3,
          onChange: (value) {
            if (value.isNotEmpty)
              _focusNode4.requestFocus();
            else
              _focusNode2.requestFocus();
          },
          onSaved: (newValue) {},
        ),
        OTP(
          controller: _otp4,
          focusNode: _focusNode4,
          onChange: (value) {
            if (value.isNotEmpty)
              _focusNode5.requestFocus();
            else
              _focusNode3.requestFocus();
          },
          onSaved: (newValue) {},
        ),
        OTP(
          controller: _otp5,
          focusNode: _focusNode5,
          onChange: (value) {
            if (value.isNotEmpty)
              _focusNode6.requestFocus();
            else
              _focusNode4.requestFocus();
          },
          onSaved: (newValue) {},
        ),
        OTP(
          controller: _otp6,
          focusNode: _focusNode6,
          onChange: (value) {
            if (value.isEmpty) _focusNode5.requestFocus();
          },
          onSaved: (newValue) {},
        ),
      ],
    );
  }

  void initFocusNode() {
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();
    _focusNode4 = FocusNode();
    _focusNode5 = FocusNode();
    _focusNode6 = FocusNode();
  }

  void disposeFocusNode() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
  }

  void runResendTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (resentRemainTime == 0)
        timer.cancel();
      else
        setState(() {
          resentRemainTime--;
        });
    });
  }
}
