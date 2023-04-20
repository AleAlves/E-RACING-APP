import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../../../../core/ui/component/ui/status_view.dart';
import '../login_recovery_password_view_model.dart';
import '../view/login_recovey_password_view.dart';

enum LoginRecoveryPasswordNavigationSet { home, status }

extension LoginRecoveryPasswordNavigation
    on LoginRecoveryPasswordNavigationSet {
  static Widget flow(LoginRecoveryPasswordViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginRecoveryPasswordNavigationSet.home:
        return LoginRecoveryPasswordView(viewModel);
      case LoginRecoveryPasswordNavigationSet.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
