import 'package:e_racing_app/home/presentation/widget/home_widget.dart';
import 'package:flutter/cupertino.dart';

import '../home_view_model.dart';

enum HomeFlow {
  home,
  error,
}

extension HomeNavigation on HomeFlow {
  static Widget flow(HomeViewModel vm) {
    switch (vm.flow) {
      case HomeFlow.home:
        return HomeWidget(vm);
      default:
        return HomeWidget(vm);
    }
  }
}