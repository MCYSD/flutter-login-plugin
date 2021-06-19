import 'package:firebase_login/provider/ForgotPasswordModel.dart';
import 'package:firebase_login/screens/common_utils.dart';
import 'package:firebase_login/screens/components/default_button.dart';
import 'package:firebase_login/screens/constants.dart';
import 'package:firebase_login/screens/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SetNewPasswordForm extends StatefulWidget {
  @override
  _SetNewPasswordFormState createState() => _SetNewPasswordFormState();
}

class _SetNewPasswordFormState extends State<SetNewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _errors = [];
  String? _password, _confirmPassword;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              marginVerticalLong,
              buildPasswordField(),
              marginVerticalNormal,
              buildConfirmPasswordField(),
              marginVerticalNormal,
              buildErrorForm(),
              marginVerticalLong,
              DefaultButton(
                text: "Set new password",
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    if (_errors.isEmpty) {
                      Provider.of<ForgotPasswordModel>(context, listen: false)
                          .setFormDisplay(ForgotPasswordModel.UPDATE_SUCCESS);
                    }
                  }
                },
              ),
              marginVerticalLong
            ],
          ),
        ));
  }

  ListView buildErrorForm() {
    return ListView.builder(
      itemCount: _errors.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Text(
        _errors[index],
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _hidePassword,
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          contentPadding: EdgeInsets.all(getProportionateScreenWidth(20)),
          labelText: "New password",
          hintText: "Enter new password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
            child: SizedBox(
              width: getProportionateScreenWidth(50),
              height: getProportionateScreenWidth(40),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                child: FaIcon(
                  _hidePassword
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash,
                  color: Colors.grey,
                  size: getProportionateScreenWidth(15),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(getProportionateScreenWidth(25)))),
              ),
            ),
          )),
      onSaved: (newValue) => _password = newValue,
      validator: (value) {
        if ((value ?? "").isEmpty && !_errors.contains(kPassNullError)) {
          setState(() {
            _errors.add(kPassNullError);
          });
        } else if ((value ?? "").length < 3 &&
            (value ?? "").isNotEmpty &&
            !_errors.contains(kShortPassError)) {
          setState(() {
            _errors.add(kShortPassError);
          });
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty && _errors.contains(kPassNullError))
          setState(() {
            _errors.remove(kPassNullError);
          });
        else if (value.isNotEmpty &&
            value.length >= 3 &&
            _errors.contains(kShortPassError))
          setState(() {
            _errors.remove(kShortPassError);
          });
      },
    );
  }

  TextFormField buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _hideConfirmPassword,
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          contentPadding: EdgeInsets.all(getProportionateScreenWidth(20)),
          labelText: "Confirm password",
          hintText: "Enter confirm password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
            child: SizedBox(
              width: getProportionateScreenWidth(50),
              height: getProportionateScreenWidth(40),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _hideConfirmPassword = !_hideConfirmPassword;
                  });
                },
                child: FaIcon(
                  _hideConfirmPassword
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash,
                  color: Colors.grey,
                  size: getProportionateScreenWidth(15),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(getProportionateScreenWidth(25)))),
              ),
            ),
          )),
      onSaved: (newValue) => _confirmPassword = newValue,
      validator: (value) {
        if (value != _passwordController.text &&
            !_errors.contains(kMatchPassError))
          setState(() {
            _errors.add(kMatchPassError);
          });

        return null;
      },
      onChanged: (value) {
        if (value == _passwordController.text &&
            _errors.contains(kMatchPassError))
          setState(() {
            _errors.remove(kMatchPassError);
          });
      },
    );
  }
}
