import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../../../../core/ui/component/ui/status_view.dart';
import '../login_onboard_view_model.dart';
import '../view/login_onboard_view.dart';

enum LoginOnboardNavigationSet { home, status }

extension LoginOnboardNavigation on LoginOnboardNavigationSet {
  static Widget flow(LoginOnboardViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginOnboardNavigationSet.home:
        return LoginOnboardView(viewModel);
      case LoginOnboardNavigationSet.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
