import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_signin_view_model.dart';
import '../view/login_signin_view.dart';

enum LoginSigninNavigationSet { home }

extension LoginSigninNavigation on LoginSigninNavigationSet {
  static Widget flow(LoginSigninViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginSigninNavigationSet.home:
        return LoginSigninView(viewModel);
    }
  }
}
