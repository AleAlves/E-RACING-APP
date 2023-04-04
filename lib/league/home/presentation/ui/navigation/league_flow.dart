import 'package:e_racing_app/league/delete/presentation/league_delete_widget.dart';
import 'package:e_racing_app/league/update/presentation/league_update_widget.dart';
import 'package:flutter/cupertino.dart';

import '../../league_view_model.dart';
import '../widget/league_detail_widget.dart';
import '../widget/league_list_widget.dart';
import '../widget/league_members_widget.dart';
import '../widget/league_status_widget.dart';

enum LeagueFlow {
  list,
  create,
  edit,
  delete,
  join,
  detail,
  error,
  status,
  members
}

extension LeagueNavigation on LeagueFlow {
  static Widget flow(LeagueViewModel vm) {
    switch (vm.flow) {
      case LeagueFlow.list:
        return LeagueListWidget(vm);
      case LeagueFlow.detail:
        return LeagueDetailWidget(vm);
      case LeagueFlow.edit:
        return LeagueUpdateWidget(vm);
      case LeagueFlow.delete:
        return LeagueDeleteWidget(vm);
      case LeagueFlow.status:
        return LeagueStatusWidget(vm);
      case LeagueFlow.members:
        return LeagueMembersWidget(vm);
      default:
        return LeagueListWidget(vm);
    }
  }
}
