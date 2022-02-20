import 'package:e_racing_app/core/model/summary_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'race_standings_summary_model.g.dart';

@JsonSerializable()
class RaceStandingsSummaryModel {
  late UserModel? user;
  late TeamModel? team;
  late SummaryModel? summary;

  RaceStandingsSummaryModel({
    required this.user,
    required this.summary,
    required this.team,
  });

  factory RaceStandingsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$RaceStandingsSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceStandingsSummaryModelToJson(this);
}
