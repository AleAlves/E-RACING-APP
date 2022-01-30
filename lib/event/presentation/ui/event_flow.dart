import 'package:e_racing_app/event/event_view_model.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_list_widget.dart';
import 'package:flutter/cupertino.dart';

enum EventFlow {
  list,
  edit,
  delete,
  join,
  detail,
  error,
  status,
  create,
  createRace,
  createChampionship
}

extension EventNavigation on EventFlow {
  static Widget flow(EventViewModel vm) {
    switch (vm.flow) {
      case EventFlow.list:
        return EventListWidget(vm);
      case EventFlow.create:
        return CreateEventWidget(vm);
      case EventFlow.createRace:
        return CreateEventRaceWidget(vm);
      case EventFlow.createChampionship:
        return CreateEventRaceWidget(vm);
      case EventFlow.detail:
        return Container();
      case EventFlow.edit:
        return Container();
      case EventFlow.join:
        return Container();
      case EventFlow.error:
        return Container();
      case EventFlow.status:
        return Container();
      default:
        return Container();
    }
  }
}
