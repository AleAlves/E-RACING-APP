import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/status_view.dart';
import '../login_sign_up_view_model.dart';
import '../view/login_sign_up_view.dart';

enum LoginSignUpNavigationSet { home, status }

extension LoginSignUpNavigation on LoginSignUpNavigationSet {
  static Widget flow(LoginSignUpViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginSignUpNavigationSet.home:
        return LoginSignUpView(viewModel);
      case LoginSignUpNavigationSet.status:
      default:
        return StatusView(viewModel);
    }
  }
}
