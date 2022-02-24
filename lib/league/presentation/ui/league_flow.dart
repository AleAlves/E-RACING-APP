
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_create_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_delete_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_detail_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_list_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_members_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_status_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_update_widget.dart';
import 'package:flutter/cupertino.dart';

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
      case LeagueFlow.create:
        return LeagueCreateWidget(vm);
      case LeagueFlow.detail:
        return LeagueDetailWidget(vm);
      case LeagueFlow.edit:
        return LeagueUpdateWidget(vm);
      case LeagueFlow.delete:
        return LeagueDeleteWidget(vm);
      case LeagueFlow.join:
        return LeagueCreateWidget(vm);
      case LeagueFlow.error:
        return LeagueCreateWidget(vm);
      case LeagueFlow.status:
        return LeagueStatusWidget(vm);
      case LeagueFlow.members:
        return LeagueMembersWidget(vm);
      default:
        return LeagueCreateWidget(vm);
    }
  }
}