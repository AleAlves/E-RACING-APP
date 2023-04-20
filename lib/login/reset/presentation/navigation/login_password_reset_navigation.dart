import 'package:e_racing_app/core/ui/component/ui/error_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/status_view.dart';
import '../login_password_reset_view_model.dart';
import '../view/login_password_reset_view.dart';

enum LoginPasswordResetNavigationSet { home, status }

extension LoginPasswordResetNavigation on LoginPasswordResetNavigationSet {
  static Widget flow(LoginPasswordResetViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginPasswordResetNavigationSet.home:
        return LoginPasswordResetView(viewModel);
      case LoginPasswordResetNavigationSet.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
