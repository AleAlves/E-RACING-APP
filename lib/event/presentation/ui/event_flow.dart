import 'package:e_racing_app/event/event_view_model.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_option_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_races_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_team_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_detail_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_detail_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_edit_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_management_race_edit_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_management_race_list_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_management_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_list_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_status_widget.dart';
import 'package:flutter/cupertino.dart';

enum EventFlows {
  list,
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
  managementEditEvent,
  managementEditRaceList,
  managementEditRace,
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
      case EventFlows.createTeam:
        return EventCreateTeamWidget(vm);
      case EventFlows.join:
        return Container();
      case EventFlows.status:
        return EventStatusWidget(vm);
      case EventFlows.manager:
        return EventManagementWidget(vm);
      case EventFlows.raceDetail:
        return EventDetailRaceWidget(vm);
      case EventFlows.managementEditEvent:
        return EventEditWidget(vm);
      case EventFlows.managementEditRaceList:
        return EventManagementRaceListWidget(vm);
      case EventFlows.managementEditRace:
        return EventManagementEditRaceWidget(vm);
      default:
        return Container();
    }
  }
}
