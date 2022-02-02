import 'package:e_racing_app/event/event_view_model.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_option_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_races_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_detail_widget.dart';
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
  createRaces,
  createEvent,
}

extension EventNavigation on EventFlows {
  static Widget flow(EventViewModel vm) {
    switch (vm.flow) {
      case EventFlows.list:
        return EventListWidget(vm);
      case EventFlows.create:
        return EventCreateOptionWidget(vm);
      case EventFlows.createRace:
        return EventCreateRaceWidget(vm);
      case EventFlows.createRaces:
        return EventCreateRaceWidget(vm);
      case EventFlows.createEvent:
        return EventCreateWidget(vm);
      case EventFlows.detail:
        return EventDetailWidget(vm);
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
