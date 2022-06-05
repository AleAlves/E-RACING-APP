import 'package:e_racing_app/event/event_view_model.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_option_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_races_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_team_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_event_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_create_single_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_detail_info_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_detail_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_detail_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_edit_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_full_standings_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_management_race_edit_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_management_race_list_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_management_race_results_edit_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_management_race_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_list_widget.dart';
import 'package:e_racing_app/event/presentation/ui/widget/event_status_widget.dart';
import 'package:flutter/cupertino.dart';

enum EventFlow {
  list,
  delete,
  status,
  create,
  manager,
  createRace,
  createRaces,
  createEvent,
  createTeam,
  detailRace,
  eventDetail,
  eventDetailInfo,
  raceDetail,
  fullStandings,
  managementEditRace,
  managementEditEvent,
  managementEditRaceList,
  managementEditRaceResultsEdit,
}

extension EventNavigation on EventFlow {
  static Widget flow(EventViewModel vm) {
    switch (vm.flow) {
      case EventFlow.list:
        return EventListWidget(vm);
      case EventFlow.create:
        return EventCreateOptionWidget(vm);
      case EventFlow.createRace:
        return EventCreateSingleRaceWidget(vm);
      case EventFlow.createRaces:
        return EventCreateRacesWidget(vm);
      case EventFlow.createEvent:
        return EventCreateEventWidget(vm);
      case EventFlow.eventDetail:
        return EventDetailWidget(vm);
      case EventFlow.detailRace:
        return EventDetailRaceWidget(vm);
      case EventFlow.createTeam:
        return EventCreateTeamWidget(vm);
      case EventFlow.eventDetailInfo:
        return EventDetailInfoWidget(vm);
      case EventFlow.status:
        return EventStatusWidget(vm);
      case EventFlow.manager:
        return EventManagementRaceWidget(vm);
      case EventFlow.raceDetail:
        return EventDetailRaceWidget(vm);
      case EventFlow.managementEditEvent:
        return EventEditWidget(vm);
      case EventFlow.managementEditRaceList:
        return EventManagementRaceListWidget(vm);
      case EventFlow.managementEditRace:
        return EventManagementEditRaceWidget(vm);
      case EventFlow.managementEditRaceResultsEdit:
        return EventManagementEditRaceResultsWidget(vm);
      case EventFlow.fullStandings:
        return EventFullStandingsWidget(vm);
      default:
        return Container();
    }
  }
}
