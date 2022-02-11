import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/tools/session.dart';

bool isSubscriber(List<ClassesModel?>? classes) {
  var isMember = false;
  classes?.forEach((element) => element?.attenders?.forEach(
      (driver) => isMember = driver == Session.instance.getUser()?.id));

  return isMember;
}

bool isHost(EventModel? event) {
  return event?.hostId == Session.instance.getUser()?.id;
}

isSubscriberOrHost(EventModel? event) {
  return isSubscriber(event?.classes) || isHost(event);
}
