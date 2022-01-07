
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_create_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_fetch_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_status_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_update_widget.dart';
import 'package:flutter/cupertino.dart';

enum LeagueFlow {
  list,
  create,
  edit,
  delete,
  join,
  error,
  status
}

extension LeagueNavigation on LeagueFlow {
  static Widget flow(LeagueViewModel vm) {
    switch (vm.flow) {
      case LeagueFlow.list:
        return LeagueListWidget(vm);
      case LeagueFlow.create:
        return LeagueCreateWidget(vm);
      case LeagueFlow.delete:
        return LeagueCreateWidget(vm);
      case LeagueFlow.edit:
        return LeagueUpdateWidget(vm);
      case LeagueFlow.join:
        return LeagueCreateWidget(vm);
      case LeagueFlow.error:
        return LeagueCreateWidget(vm);
      case LeagueFlow.status:
        return LeagueStatusWidget(vm);
      default:
        return LeagueCreateWidget(vm);
    }
  }
}