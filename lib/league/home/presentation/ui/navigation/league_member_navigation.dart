import 'package:e_racing_app/league/delete/presentation/league_delete_widget.dart';
import 'package:e_racing_app/league/update/presentation/league_update_widget.dart';
import 'package:flutter/cupertino.dart';

import '../../league_view_model.dart';
import '../widget/league_members_widget.dart';

enum LeagueDetailNavigationSet {
  create,
  edit,
  delete,
  join,
  detail,
  error,
  status,
  members
}

extension LeagueMemberNavigation on LeagueDetailNavigationSet {
  static Widget flow(LeagueViewModel vm) {
    switch (vm.flow) {
      case LeagueDetailNavigationSet.edit:
        return LeagueUpdateWidget(vm);
      case LeagueDetailNavigationSet.delete:
        return LeagueDeleteWidget(vm);
      case LeagueDetailNavigationSet.members:
        return LeagueMembersWidget(vm);
      case LeagueDetailNavigationSet.status:
        return Container();
      default:
        return Container();
    }
  }
}
