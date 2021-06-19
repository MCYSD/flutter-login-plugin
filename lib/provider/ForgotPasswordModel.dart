import 'dart:core';
import 'package:flutter/cupertino.dart';

class ForgotPasswordModel extends ChangeNotifier {
  static const int FORGOT_PASSWORD_FORM = 0;
  static const int ENTER_VERIFY_CODE_FORM = 1;
  static const int SET_NEW_PASSWORD_FORM = 2;
  static const int UPDATE_SUCCESS = 3;
  static const int RESET_LINK_HAS_SENT = 4;

  int _formDisplay = FORGOT_PASSWORD_FORM;
  String? _email = "";

  void setFormDisplay(int formDisplay, {String? email}) {
    _formDisplay = formDisplay;
    _email = email;
    notifyListeners();
  }

  int get getFormDisplay => _formDisplay;
  String? get getEmail => _email;
}
