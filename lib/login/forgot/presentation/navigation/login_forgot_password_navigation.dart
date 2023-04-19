import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_forgot_password_view_model.dart';
import '../view/login_forgot_password_view.dart';

enum LoginForgotPasswordNavigationSet { home }

extension LoginForgotPasswordNavigation on LoginForgotPasswordNavigationSet {
  static Widget flow(LoginForgotPasswordViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginForgotPasswordNavigationSet.home:
        return LoginForgotPasswordView(viewModel);
    }
  }
}
