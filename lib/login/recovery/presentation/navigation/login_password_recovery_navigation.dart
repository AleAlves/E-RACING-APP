import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../../../../core/ui/component/ui/status_view.dart';
import '../login_password_recovery_view_model.dart';
import '../view/login_password_recovery_view.dart';
import '../view/login_password_reset_view.dart';

enum LoginPasswordRecoveryNavigationSet { recover, reset, status }

extension LoginPasswordRecoveryNavigation
    on LoginPasswordRecoveryNavigationSet {
  static Widget flow(LoginPasswordRecoveryViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginPasswordRecoveryNavigationSet.recover:
        return LoginPasswordRecoveryView(viewModel);
      case LoginPasswordRecoveryNavigationSet.reset:
        return LoginPasswordResetView(viewModel);
      case LoginPasswordRecoveryNavigationSet.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
