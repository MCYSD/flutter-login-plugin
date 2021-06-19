import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/screens/common_utils.dart';
import 'package:firebase_login/screens/components/custom_suffix_icon.dart';
import 'package:firebase_login/screens/components/default_button.dart';
import 'package:firebase_login/screens/components/fail_dialog.dart';
import 'package:firebase_login/screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  UserRepository _userRepository = UserRepository();
  String? email, password, confirmPassword;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isLoading = false;
  List<String> errors = [];
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24)),
              child: Column(
                children: [
                  buildEmailTextField(),
                  marginVerticalNormal,
                  buildPasswordTextField(),
                  marginVerticalNormal,
                  buildConfirmPasswordTextField(),
                  marginVerticalNormal,
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: errors.length,
                    itemBuilder: (context, index) {
                      return Text(
                        errors[index],
                        style: TextStyle(color: Colors.red),
                      );
                    },
                  ),
                  marginVerticalNormal,
                  DefaultButton(
                    text: "Create account",
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        if (errors.isEmpty) {
                          _formKey.currentState!.save();
                          setState(() {
                            isLoading = true;
                          });
                          String? error = await _userRepository.createAccount(
                              email ?? "", password ?? "");
                          if ((error ?? "").isEmpty)
                            Navigator.pop(context);
                          else {
                            setState(() {
                              isLoading = false;
                              showDialog(
                                context: context,
                                builder: (context) => FailDialog(
                                  context: context,
                                  title: "Register fail",
                                  message: error,
                                ),
                                barrierDismissible: true,
                              );
                            });
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            )),
        isLoading
            ? loadingForm
            : Container(
                width: 0,
                height: 0,
              ),
      ],
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        contentPadding: EdgeInsets.all(getProportionateScreenWidth(20)),
        hintText: "Enter your email",
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          icon: "assets/icons/Mail.svg",
        ),
      ),
      onSaved: (newValue) => email = newValue,
      validator: (value) {
        if ((value ?? "").isEmpty && !errors.contains(kEmailNullError))
          setState(() {
            errors.add(kEmailNullError);
          });
        else if (!emailValidatorRegExp.hasMatch((value ?? "")) &&
            !errors.contains(kInvalidEmailError) &&
            !errors.contains(kEmailNullError))
          setState(() {
            errors.add(kInvalidEmailError);
          });
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError))
          setState(() {
            errors.remove(kEmailNullError);
          });
        else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError))
          setState(() {
            errors.remove(kInvalidEmailError);
          });

        return null;
      },
    );
  }

  TextFormField buildPasswordTextField() {
    return TextFormField(
      obscureText: _hidePassword,
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        contentPadding: EdgeInsets.all(getProportionateScreenWidth(20)),
        hintText: "Enter your password",
        labelText: "Password",
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
        ),
      ),
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if ((value ?? "").isEmpty && !errors.contains(kPassNullError))
          setState(() {
            errors.add(kPassNullError);
          });
        else if ((value ?? "").length < 6 &&
            !errors.contains(kShortPassError) &&
            !errors.contains(kPassNullError))
          setState(() {
            errors.add(kShortPassError);
          });
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError))
          setState(() {
            errors.remove(kPassNullError);
          });
        else if (value.length >= 6 && errors.contains(kShortPassError))
          setState(() {
            errors.remove(kShortPassError);
          });
        else if (value == _confirmPasswordController.text &&
            errors.contains(kMatchPassError))
          setState(() {
            errors.remove(kMatchPassError);
          });
        return null;
      },
    );
  }

  TextFormField buildConfirmPasswordTextField() {
    return TextFormField(
      obscureText: _hideConfirmPassword,
      controller: _confirmPasswordController,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        contentPadding: EdgeInsets.all(getProportionateScreenWidth(20)),
        hintText: "Re-Enter your password",
        labelText: "Confirm Password",
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
        ),
      ),
      onSaved: (newValue) => confirmPassword = newValue,
      validator: (value) {
        if (value != _passwordController.text &&
            !errors.contains(kMatchPassError))
          setState(() {
            errors.add(kMatchPassError);
          });

        return null;
      },
      onChanged: (value) {
        if (value == _passwordController.text &&
            errors.contains(kMatchPassError))
          setState(() {
            errors.remove(kMatchPassError);
          });
        return null;
      },
    );
  }
}
