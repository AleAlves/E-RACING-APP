import 'package:e_racing_app/login/presentation/login_view_model.dart';
import 'package:e_racing_app/login/presentation/widget/login_2fa_otp_qr_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_2fa_otp_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_2fa_toogle_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_forgot_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_form_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_initial_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_reset_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_signin_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_status_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum LoginWidgetFlow {
  init,
  login,
  signin,
  login2fa,
  toogle2fa,
  otpQr,
  forgot,
  registration,
  reset,
  resetCode,
  status
}

extension LoginNavigation on LoginWidgetFlow {
  static Widget flow(LoginViewModel vm) {
    switch (vm.flow) {
      case LoginWidgetFlow.init:
        return LoginInitialWidget(vm);
      case LoginWidgetFlow.login:
        return LoginFormWidget(vm);
      case LoginWidgetFlow.signin:
        return LoginSigninWidget(vm);
      case LoginWidgetFlow.login2fa:
        return Login2FAWidget(vm);
      case LoginWidgetFlow.toogle2fa:
        return LoginToogle2FAWidget(vm);
      case LoginWidgetFlow.otpQr:
        return LoginOtpQRWidget(vm);
      case LoginWidgetFlow.forgot:
        return LoginForgotWidget(vm);
      case LoginWidgetFlow.registration:
        return LoginStatusWidget(vm);
      case LoginWidgetFlow.reset:
        return LoginResetWidget(vm);
      case LoginWidgetFlow.resetCode:
        return LoginForgotWidget(vm);
      case LoginWidgetFlow.status:
        return LoginStatusWidget(vm);
    }
  }
}
