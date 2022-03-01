import 'package:e_racing_app/event/event_view_model.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_option_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_races_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_team_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_detail_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_detail_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_edit_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_manager_area_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_list_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_status_widget.dart';
import 'package:flutter/cupertino.dart';

enum EventFlows {
  list,
  editEvent,
  delete,
  join,
  eventDetail,
  raceDetail,
  status,
  create,
  manager,
  createRace,
  createRaces,
  createEvent,
  createTeam,
  detailRace,
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
        return EventCreateRacesWidget(vm);
      case EventFlows.createEvent:
        return EventCreateWidget(vm);
      case EventFlows.eventDetail:
        return EventDetailWidget(vm);
      case EventFlows.detailRace:
        return EventDetailRaceWidget(vm);
      case EventFlows.editEvent:
        return EventEditWidget(vm);
      case EventFlows.createTeam:
        return EventCreateTeamWidget(vm);
      case EventFlows.join:
        return Container();
      case EventFlows.status:
        return EventStatusWidget(vm);
      case EventFlows.manager:
        return EventManagerAreaWidget(vm);
      case EventFlows.raceDetail:
        return EventDetailRaceWidget(vm);
      default:
        return Container();
    }
  }
}
