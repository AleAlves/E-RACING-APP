import 'package:json_annotation/json_annotation.dart';

import 'event_standing_classes_model.dart';

part 'event_standings_model.g.dart';

@JsonSerializable()
class EventStandingsModel {
  late String eventId;
  late List<EventStandingClassesModel?>? classes;

  EventStandingsModel({required this.eventId, required this.classes});

  factory EventStandingsModel.fromJson(Map<String, dynamic> json) =>
      _$EventStandingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventStandingsModelToJson(this);
}
