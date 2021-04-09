import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/screens/components/custom_suffix_icon.dart';
import 'package:firebase_login/screens/components/default_button.dart';
import 'package:firebase_login/screens/components/fail_dialog.dart';
import 'package:firebase_login/screens/constants.dart';
import 'package:firebase_login/screens/forgot_password/forgot_password_screen.dart';
import 'package:firebase_login/screens/sign_up/sign_up_screen.dart';
import 'package:firebase_login/screens/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common_utils.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _userRepository = UserRepository();
  String email, password;
  bool isRememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final List<String> error = [];
  bool _hidePassword = true;

  bool isLoading = false;
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
                  buildEmailTextField(outlineInputBorder),
                  marginVerticalNormal,
                  buildPasswordTextField(outlineInputBorder),
                  marginVerticalNormal,
                  Align(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ));
                      },
                      child: Text("Forgot password",
                          style: TextStyle(color: Colors.blue)),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  marginVerticalNormal,
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: error.length,
                    itemBuilder: (context, index) {
                      return Text(
                        error[index],
                        style: TextStyle(color: Colors.red),
                      );
                    },
                  ),
                  marginVerticalNormal,
                  DefaultButton(
                    text: "Continue",
                    onPress: () async {
                      if (_formKey.currentState.validate()) {
                        if (error.isEmpty) {
                          _formKey.currentState.save();
                          setState(() {
                            isLoading = true;
                          });
                          //if login success, the OnUserStateChange were auto trigger
                          //so no need to implement success case
                          //we just handle when login fail
                          //when login fail, an string error will be return
                          String error = await _userRepository
                              .signInWithEmailAndPass(email, password);
                          setState(() {
                            isLoading = false;
                            if (error != "") {
                              showDialog(
                                context: context,
                                builder: (context) => FailDialog(
                                  context: context,
                                  title: "Login fail",
                                  message: error,
                                ),
                                barrierDismissible: true,
                              );
                            }
                          });
                        }
                      }
                    },
                  ),
                  marginVerticalLong,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You don't have account"),
                      marginHorizontalSmall,
                      InkWell(
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ));
                        },
                      )
                    ],
                  )
                ],
              ),
            )),
        isLoading
            ? loadingForm
            : Container(
                width: 0,
                height: 0,
              )
      ],
    );
  }

  TextFormField buildPasswordTextField(OutlineInputBorder outlineInputBorder) {
    return TextFormField(
      obscureText: _hidePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
          child: SizedBox(
            width: getProportionateScreenWidth(50),
            height: getProportionateScreenWidth(55),
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
      onChanged: (value) {
        if (value.isNotEmpty && error.contains(kPassNullError))
          setState(() {
            error.remove(kPassNullError);
          });
        else if (value.length >= 6 && error.contains(kShortPassError))
          setState(() {
            error.remove(kShortPassError);
          });

        return null;
      },
      validator: (value) {
        if (value.isEmpty && !error.contains(kPassNullError))
          setState(() {
            error.add(kPassNullError);
          });
        else if (value.length < 6 &&
            !error.contains(kShortPassError) &&
            !error.contains(kPassNullError))
          setState(() {
            error.add(kShortPassError);
          });
        return null;
      },
    );
  }

  TextFormField buildEmailTextField(OutlineInputBorder outlineInputBorder) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          icon: "assets/icons/Mail.svg",
        ),
      ),
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && error.contains(kEmailNullError))
          setState(() {
            error.remove(kEmailNullError);
          });
        else if (emailValidatorRegExp.hasMatch(value) &&
            error.contains(kInvalidEmailError))
          setState(() {
            error.remove(kInvalidEmailError);
          });
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !error.contains(kEmailNullError))
          setState(() {
            error.add(kEmailNullError);
          });
        else if (!emailValidatorRegExp.hasMatch(value) &&
            !error.contains(kEmailNullError) &&
            !error.contains(kInvalidEmailError))
          setState(() {
            error.add(kInvalidEmailError);
          });
        return null;
      },
    );
  }
}
