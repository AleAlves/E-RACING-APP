import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../../../../core/ui/component/ui/status_view.dart';
import '../event_update_view_model.dart';
import '../view/event_update_race_view.dart';
import '../view/event_update_view.dart';

enum EventUpdateRouter { main, race, status }

extension EventUpdateNavigation on EventUpdateRouter {
  static Widget flow(EventUpdateViewModel viewModel) {
    switch (viewModel.flow) {
      case EventUpdateRouter.main:
        return EventUpdateView(viewModel);
      case EventUpdateRouter.race:
        return EventUpdateRaceView(viewModel);
      case EventUpdateRouter.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
