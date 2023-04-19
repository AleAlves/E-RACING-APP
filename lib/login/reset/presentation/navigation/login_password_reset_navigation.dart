import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_password_reset_view_model.dart';
import '../view/login_password_reset_view.dart';

enum LoginPasswordResetNavigationSet { home }

extension LoginPasswordResetNavigation on LoginPasswordResetNavigationSet {
  static Widget flow(LoginPasswordResetViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginPasswordResetNavigationSet.home:
        return LoginPasswordResetView(viewModel);
    }
  }
}
