import 'package:firebase_login/provider/ForgotPasswordModel.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/screens/components/default_button.dart';
import 'package:firebase_login/screens/components/fail_dialog.dart';
import 'package:firebase_login/screens/constants.dart';
import 'package:firebase_login/screens/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_utils.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  UserRepository _userRepository = UserRepository();
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  final List<String> _errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            marginVerticalNormal,
            buildPhoneNumberTextField(),
            marginVerticalNormal,
            buildErrorForm(),
            marginVerticalNormal,
            DefaultButton(
              text: "Send verify code",
              onPress: () async {
                if (_formKey.currentState.validate()) {
                  if (_errors.isEmpty) {
                    _formKey.currentState.save();
                    String error =
                        await _userRepository.sendPasswordResetEmail(_email);
                    if (error.isEmpty)
                      Provider.of<ForgotPasswordModel>(context, listen: false)
                          .setFormDisplay(
                              ForgotPasswordModel.RESET_LINK_HAS_SENT,
                              email: _email);
                    else
                      showDialog(
                        context: context,
                        builder: (context) => FailDialog(
                          context: context,
                          title: "Require reset password fail",
                          message: error,
                        ),
                      );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  ListView buildErrorForm() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _errors.length,
      itemBuilder: (context, index) {
        return Text(_errors[index], style: TextStyle(color: Colors.red));
      },
    );
  }

  TextFormField buildPhoneNumberTextField() {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: getProportionateScreenWidth(18)),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(20),
          horizontal: getProportionateScreenWidth(20),
        ),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        labelText: "Enter your email address",
      ),
      validator: (value) {
        if (value.isEmpty && !_errors.contains(kEmailNullError)) {
          setState(() {
            _errors.add(kEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !_errors.contains(kInvalidEmailError) &&
            value.isNotEmpty) {
          setState(() {
            _errors.add(kInvalidEmailError);
          });
        }

        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty && _errors.contains(kEmailNullError)) {
          setState(() {
            _errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            _errors.contains(kInvalidEmailError)) {
          setState(() {
            _errors.remove(kInvalidEmailError);
          });
        }
      },
      onSaved: (newValue) => _email = newValue,
    );
  }
}
