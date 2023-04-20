import 'package:e_racing_app/login/legacy/presentation/login_view_model.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/widget/login_2fa_otp_qr_widget.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/widget/login_2fa_otp_widget.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/widget/login_2fa_toogle_widget.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/widget/login_forgot_widget.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/widget/login_reset_widget.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/widget/login_signin_widget.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/widget/login_status_widget.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/widget/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum LoginWidgetFlow {
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
      case LoginWidgetFlow.login:
        return LoginView(vm);
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
