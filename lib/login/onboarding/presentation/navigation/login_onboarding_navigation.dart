import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_onboarding_view_model.dart';
import '../view/login_onboarding_view.dart';

enum LoginOnboardingNavigationSet { home }

extension LoginOnboardingNavigation on LoginOnboardingNavigationSet {
  static Widget flow(LoginOnboardingViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginOnboardingNavigationSet.home:
        return LoginOnboardingView(viewModel);
    }
  }
}
