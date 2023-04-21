import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_view_model.dart';
import '../view/app_enviroment_view.dart';

enum AppNavigationSet { appEnviroment }

extension AppNavigation on AppNavigationSet {
  static Widget flow(AppViewModel viewModel) {
    switch (viewModel.flow) {
      case AppNavigationSet.appEnviroment:
        return AppEnviromentView(viewModel);
      default:
        return Container();
    }
  }
}
