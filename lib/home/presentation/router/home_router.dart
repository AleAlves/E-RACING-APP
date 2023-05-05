import 'package:e_racing_app/home/presentation/view/home_view.dart';
import 'package:flutter/cupertino.dart';

import '../home_view_model.dart';

enum HomeRouter {
  main,
  error,
}

extension HomeNavigation on HomeRouter {
  static Widget flow(HomeViewModel vm) {
    switch (vm.flow) {
      case HomeRouter.main:
        return HomeView(vm);
      default:
        return HomeView(vm);
    }
  }
}
