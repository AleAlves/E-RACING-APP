import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/ui/component/ui/error_view.dart';
import '../../../../../core/ui/component/ui/status_view.dart';
import '../event_manage_view_model.dart';
import '../view/event_manage_race_results_view.dart';
import '../view/event_manage_race_view.dart';

enum EventManageRouter { main, race, status }

extension EventManageNavigation on EventManageRouter {
  static Widget flow(EventManageViewModel viewModel) {
    switch (viewModel.flow) {
      case EventManageRouter.main:
        return EventManageRaceView(viewModel);
      case EventManageRouter.race:
        return EventManageRaceResultsView(viewModel);
      case EventManageRouter.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
