import 'package:e_racing_app/core/ui/component/ui/status_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../league_member_view_model.dart';
import '../view/league_members_view.dart';

enum LeagueMemberNavigationSet { main, status }

extension LeagueMemberNavigation on LeagueMemberNavigationSet {
  static Widget flow(LeagueMemberViewModel viewModel) {
    switch (viewModel.flow) {
      case LeagueMemberNavigationSet.main:
        return LeagueMembersView(viewModel);
      case LeagueMemberNavigationSet.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
