import 'package:e_racing_app/core/ui/component/ui/status_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../login_sign_in_view_model.dart';
import '../view/login_sign_in_view.dart';

enum LoginSignInNavigationSet { home, status }

extension LoginSignInNavigation on LoginSignInNavigationSet {
  static Widget flow(LoginSignInViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginSignInNavigationSet.home:
        return LoginSignInView(viewModel);
      case LoginSignInNavigationSet.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
