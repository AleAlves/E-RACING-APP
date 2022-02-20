import 'dart:ui';

import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/session_model.dart';

String getSessionType(SessionType? type) {
  switch (type) {
    case SessionType.warmup:
      return "Warmup";
    case SessionType.practice:
      return "Practice";
    case SessionType.qualify:
      return "Qualify";
    case SessionType.race:
      return "Race";
    default:
      return "Unknow";
  }
}

String? getEventStatus(EventState? state) {
  switch (state) {
    case EventState.idle:
      return "In preparation";
    case EventState.ongoing:
      return "On going";
    case EventState.finished:
      return "Finished";
    default:
      return "unknow";
  }
}