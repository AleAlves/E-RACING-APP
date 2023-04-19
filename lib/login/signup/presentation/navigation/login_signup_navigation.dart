import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_signup_view_model.dart';
import '../view/login_signup_view.dart';

enum LoginSignupNavigationSet { home }

extension LoginSignupNavigation on LoginSignupNavigationSet {
  static Widget flow(LoginSignupViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginSignupNavigationSet.home:
        return LoginSignupView(viewModel);
    }
  }
}
