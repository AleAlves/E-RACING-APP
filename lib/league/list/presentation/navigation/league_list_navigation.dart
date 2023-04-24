import 'package:e_racing_app/core/ui/component/ui/status_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../league_list_view_model.dart';
import '../view/league_list_view.dart';

enum LeagueListNavigationSet { main, status }

extension LeagueListNavigation on LeagueListNavigationSet {
  static Widget flow(LeagueListViewModel viewModel) {
    switch (viewModel.flow) {
      case LeagueListNavigationSet.main:
        return LeagueListView(viewModel);
      case LeagueListNavigationSet.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
