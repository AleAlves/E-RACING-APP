import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/event/data/race_standings_summary_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'race_standings_session_model.g.dart';

@JsonSerializable()
class RaceStandingsSessionModel {
  late String? sessionName;
  late List<RaceStandingsSummaryModel>? standings;

  RaceStandingsSessionModel({
    required this.sessionName,
    required this.standings,
  });

  factory RaceStandingsSessionModel.fromJson(Map<String, dynamic> json) =>
      _$RaceStandingsSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceStandingsSessionModelToJson(this);
}
