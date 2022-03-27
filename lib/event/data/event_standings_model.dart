import 'package:json_annotation/json_annotation.dart';

import 'race_standings_model.dart';

part 'event_standings_model.g.dart';

@JsonSerializable()
class EventStandingsModel {
  late String eventId;

  EventStandingsModel({required this.eventId});

  factory EventStandingsModel.fromJson(Map<String, dynamic> json) =>
      _$EventStandingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventStandingsModelToJson(this);
}
