import 'package:e_racing_app/event/event_view_model.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_championship_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_championship_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_list_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_status_widget.dart';
import 'package:flutter/cupertino.dart';

enum EventFlows {
  list,
  edit,
  delete,
  join,
  detail,
  status,
  create,
  createRace,
  createChampionshipEvent,
  createChampionshipRaces
}

extension EventNavigation on EventFlows {
  static Widget flow(EventViewModel vm) {
    switch (vm.flow) {
      case EventFlows.list:
        return EventListWidget(vm);
      case EventFlows.create:
        return CreateEventWidget(vm);
      case EventFlows.createRace:
        return CreateEventRaceWidget(vm);
      case EventFlows.createChampionshipEvent:
        return CreateEventChampionshipWidget(vm);
      case EventFlows.createChampionshipRaces:
        return CreateChampionshipRaceWidget(vm);
      case EventFlows.detail:
        return Container();
      case EventFlows.edit:
        return Container();
      case EventFlows.join:
        return Container();
      case EventFlows.status:
        return EventStatusWidget(vm);
      default:
        return Container();
    }
  }
}
