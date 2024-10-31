import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_view_model.dart';
import '../view/app_environment_view.dart';

enum AppNavigationSet { appEnvironment }

extension AppNavigation on AppNavigationSet {
  static Widget flow(AppViewModel viewModel) {
    switch (viewModel.flow) {
      case AppNavigationSet.appEnvironment:
        return AppEnvironmentView(viewModel);
      default:
        return Container();
    }
  }
}
