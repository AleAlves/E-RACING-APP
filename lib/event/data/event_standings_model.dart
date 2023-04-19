import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_standings_model.g.dart';

@JsonSerializable()
class EventStandingsModel {
  final String? eventId;
  final List<EventStandingsClassesModel?>? classes;

  EventStandingsModel({this.eventId, this.classes});

  factory EventStandingsModel.fromJson(Map<String, dynamic> json) =>
      _$EventStandingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventStandingsModelToJson(this);
}


@JsonSerializable()
class EventStandingsClassesModel {
  String? className;
  List<EventStandingSummaryModel?>? summaries;

  EventStandingsClassesModel({required this.className, required this.summaries});

  factory EventStandingsClassesModel.fromJson(Map<String, dynamic> json) =>
      _$EventStandingsClassesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventStandingsClassesModelToJson(this);
}


@JsonSerializable()
class EventStandingSummaryModel {
  @JsonKey(name: '_id')
  final String? id;
  final UserModel? user;
  final int? points;
  final int? wins;
  final int? top5;
  final int? top10;
  final int? bonus;
  final int? place;
  final int? penalties;
  final int? desqualifies;
  final int? bestPosition;
  final int? worstPosition;

  EventStandingSummaryModel({
    required this.id,
    required this.user,
    required this.points,
    required this.wins,
    required this.top5,
    required this.top10,
    required this.bonus,
    required this.place,
    required this.penalties,
    required this.desqualifies,
    required this.bestPosition,
    required this.worstPosition,
  });

  factory EventStandingSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$EventStandingSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventStandingSummaryModelToJson(this);
}
