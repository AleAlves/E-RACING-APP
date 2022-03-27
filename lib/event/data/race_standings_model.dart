import 'package:e_racing_app/event/data/race_standings_session_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'race_standings_model.g.dart';

@JsonSerializable()
class RaceStandingsModel {
  late List<RaceStandingsSessionModel?>? sessions;

  RaceStandingsModel({required this.sessions});

  factory RaceStandingsModel.fromJson(Map<String, dynamic> json) =>
      _$RaceStandingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceStandingsModelToJson(this);
}
