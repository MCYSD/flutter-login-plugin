import 'package:firebase_login/provider/ForgotPasswordModel.dart';
import 'package:firebase_login/screens/common_utils.dart';
import 'package:firebase_login/screens/forgot_password/components/enter_verify_code_form.dart';
import 'package:firebase_login/screens/forgot_password/components/enter_verify_code_header.dart';
import 'package:firebase_login/screens/forgot_password/components/forgot_password_form.dart';
import 'package:firebase_login/screens/forgot_password/components/forgot_password_header.dart';
import 'package:firebase_login/screens/forgot_password/components/link_reset_has_sent_form.dart';
import 'package:firebase_login/screens/forgot_password/components/link_reset_has_sent_header.dart';
import 'package:firebase_login/screens/forgot_password/components/set_new_password_form.dart';
import 'package:firebase_login/screens/forgot_password/components/set_new_password_header.dart';
import 'package:firebase_login/screens/forgot_password/components/update_password_success_form.dart';
import 'package:firebase_login/screens/forgot_password/components/update_password_success_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordModel>(
      builder: (context, forgotPasswordModel, child) {
        Widget header = buildHeader(forgotPasswordModel);
        Widget body = buildBody(forgotPasswordModel);

        return Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [header, marginVerticalLong, body],
            ),
          ),
        );
      },
    );
  }

  Widget buildHeader(ForgotPasswordModel forgotPasswordModel) {
    switch (forgotPasswordModel.getFormDisplay) {
      case ForgotPasswordModel.FORGOT_PASSWORD_FORM:
        return ForgotPasswordHeader();
      case ForgotPasswordModel.ENTER_VERIFY_CODE_FORM:
        return EnterVefiryCodeHeader(email: forgotPasswordModel.getEmail!);
      case ForgotPasswordModel.SET_NEW_PASSWORD_FORM:
        return SetNewPasswordHeader();
      case ForgotPasswordModel.UPDATE_SUCCESS:
        return UpdatePasswordSuccessHeader();
      default:
        return LinkResetHasSentHeader();
    }
  }

  Widget buildBody(ForgotPasswordModel forgotPasswordModel) {
    switch (forgotPasswordModel.getFormDisplay) {
      case ForgotPasswordModel.FORGOT_PASSWORD_FORM:
        return ForgotPasswordForm();
      case ForgotPasswordModel.ENTER_VERIFY_CODE_FORM:
        return EnterVerifyCodeForm();
      case ForgotPasswordModel.SET_NEW_PASSWORD_FORM:
        return SetNewPasswordForm();
      case ForgotPasswordModel.UPDATE_SUCCESS:
        return UpdatePasswordSuccessForm();
      default:
        return LinkResetHasSentForm();
    }
  }
}
