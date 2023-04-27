import 'package:e_racing_app/event/detail/presentation/view/event_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../../../../core/ui/component/ui/status_view.dart';
import '../event_detail_view_model.dart';
import '../view/event_detail_info_view.dart';
import '../view/event_detail_race_view.dart';
import '../view/event_detail_standings_view.dart';

enum EventDetailRouter { main, standings, info, race, status }

extension EventDetailNavigation on EventDetailRouter {
  static Widget flow(EventDetailViewModel viewModel) {
    switch (viewModel.flow) {
      case EventDetailRouter.main:
        return EventDetailView(viewModel);
      case EventDetailRouter.info:
        return EventDetailInfoView(viewModel);
      case EventDetailRouter.standings:
        return EventDetailStandingsView(viewModel);
      case EventDetailRouter.race:
        return EventDetailRaceView(viewModel);
      case EventDetailRouter.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
