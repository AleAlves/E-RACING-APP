import 'package:e_racing_app/core/ui/component/ui/status_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../league_list_view_model.dart';
import '../view/league_list_owned_view.dart';
import '../view/league_list_view.dart';

enum LeagueListRouterSet { main, owned, status }

extension LeagueListRouting on LeagueListRouterSet {
  static Widget flow(LeagueListViewModel viewModel) {
    switch (viewModel.flow) {
      case LeagueListRouterSet.main:
        return LeagueListView(viewModel);
      case LeagueListRouterSet.owned:
        return LeagueListOwnedView(viewModel);
      case LeagueListRouterSet.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
