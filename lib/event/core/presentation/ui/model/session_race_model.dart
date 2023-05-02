import 'package:e_racing_app/core/model/session_model.dart';

class EventRaceModel {
  String? id;
  String? poster;
  String? title;
  String? eventDate;
  String? broadcastLink;
  bool? hasBroadcasting;
  List<SessionModel?>? sessions;

  EventRaceModel(
      {required this.title,
      required this.hasBroadcasting,
      required this.eventDate,
      required this.sessions,
      this.broadcastLink,
      this.poster,
      this.id});
}
