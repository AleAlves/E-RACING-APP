import 'package:flutter/cupertino.dart';

import '../league_trophies_view_model.dart';
import '../view/league_trophies_view.dart';

enum LeagueTrophiesRouter {
  main,
  error,
}

extension LeagueTrophiesNavigator on LeagueTrophiesRouter {
  static Widget flow(LeagueTrophiesViewModel viewModel) {
    switch (viewModel.flow) {
      case LeagueTrophiesRouter.main:
        return LeagueTrophiesView(viewModel);
      default:
        return LeagueTrophiesView(viewModel);
    }
  }
}
