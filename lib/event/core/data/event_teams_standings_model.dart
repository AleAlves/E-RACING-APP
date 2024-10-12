import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/summary_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_teams_standings_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EventTeamsStandingsModel {

  String? eventId;
  List<TeamsStandingsModel?>? summaries;

  EventTeamsStandingsModel({required this.eventId, required this.summaries });

  factory EventTeamsStandingsModel.fromJson(Map<String, dynamic> json) =>
      _$EventTeamsStandingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventTeamsStandingsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TeamsStandingsModel {
  List<UserModel?>? users;
  TeamModel? team;
  int? points;

  TeamsStandingsModel({
    required this.users,
    required this.points,
    required this.team
  });

  factory TeamsStandingsModel.fromJson(Map<String, dynamic> json) =>
      _$TeamsStandingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamsStandingsModelToJson(this);
}

