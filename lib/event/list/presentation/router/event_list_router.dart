import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/error_view.dart';
import '../../../../core/ui/component/ui/status_view.dart';
import '../event_list_view_model.dart';
import '../view/event_list_view.dart';

enum EventListRouter { main, status }

extension EventListNavigation on EventListRouter {
  static Widget flow(EventListViewModel viewModel) {
    switch (viewModel.flow) {
      case EventListRouter.main:
        return EventListView(viewModel);
      case EventListRouter.status:
        return StatusView(viewModel);
      default:
        return ErrorView(viewModel);
    }
  }
}
