import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';

bool isSubscriber(List<ClassesModel?>? classes) {
  var isSus = false;
  classes?.forEach((element) => element?.drivers?.forEach(
      (driver) => isSus = driver?.driverId == Session.instance.getUser()?.id));
  return isSus;
}

bool isEventHost(EventModel? event) {
  return event?.hostId == Session.instance.getUser()?.id;
}

bool isLeagueManager(LeagueModel? league) {
  return league?.owner == Session.instance.getUser()?.id;
}

bool isLeagueMember(LeagueModel? league) {
  return league?.members
          ?.where(
              (element) => element?.memberId == Session.instance.getUser()?.id)
          .isNotEmpty ??
      false;
}

isSubscriberOrHost(EventModel? event) {
  return isSubscriber(event?.classes) || isEventHost(event);
}
