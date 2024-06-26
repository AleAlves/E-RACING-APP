import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:e_racing_app/profile/ProfileRouter.dart';

import '../../core/tools/session.dart';
import '../../league/LeagueRouter.dart';
import 'model/notification_model.dart';

class GetNotificationsFlowUseCase<T> extends BaseUseCase<T?> {
  late List<NotificationSourceModel>? _document;

  GetNotificationsFlowUseCase<T> params({required List<dynamic>? document}) {
    _document = document
        ?.map<NotificationSourceModel>(
            (event) => NotificationSourceModel.fromJson(event))
        .toList();
    return this;
  }

  @override
  Future<T?> invoke(
      {required Function(T?) success, required Function failure}) async {
    String? action;
    String? raceAction;
    String? eventAction;
    String? leagueAction;
    _document?.forEach((doc) {
      switch (doc.type) {
        case NotificationTypeModel.race:
          Session.instance.setRaceId(doc.sourceId);
          raceAction = EventRouter.detail;
          break;
        case NotificationTypeModel.event:
          Session.instance.setEventId(doc.sourceId);
          eventAction = EventRouter.list;
          break;
        case NotificationTypeModel.league:
          Session.instance.setLeagueId(doc.sourceId);
          leagueAction = LeagueRouter.detail;
          break;
        case NotificationTypeModel.profile:
          action = ProfileRouter.main;
          break;
      }
    });
    if (leagueAction != null) {
      action = leagueAction;
    }
    if (eventAction != null && leagueAction != null) {
      action = eventAction;
    }
    if (raceAction != null && eventAction != null && leagueAction != null) {
      action = raceAction;
    }
    success(action as T);
  }
}
