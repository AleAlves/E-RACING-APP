import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/event/data/race_standings_summary_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'race_standings_model.g.dart';

@JsonSerializable()
class RaceStandingsModel {
  late ClassesModel? raceClass;
  late List<RaceStandingsSummaryModel>? standings;

  RaceStandingsModel({
    required this.raceClass,
    required this.standings,
  });

  factory RaceStandingsModel.fromJson(Map<String, dynamic> json) =>
      _$RaceStandingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceStandingsModelToJson(this);
}
