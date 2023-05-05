import 'package:e_racing_app/core/ui/component/ui/status_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../../../update/presentation/league_update_view.dart';
import '../league_detail_view_model.dart';
import '../view/league_detail_view.dart';

enum LeagueDetailNavigationSet { main, update, status }

extension LeagueDetailNavigation on LeagueDetailNavigationSet {
  static Widget flow(LeagueDetailViewModel viewModel) {
    switch (viewModel.flow) {
      case LeagueDetailNavigationSet.main:
        return LeagueDetailView(viewModel);
      case LeagueDetailNavigationSet.update:
        return LeagueUpdateView(viewModel);
      case LeagueDetailNavigationSet.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
