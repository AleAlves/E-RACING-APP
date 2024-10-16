import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/summary_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/model/session_model.dart';

part 'race_standings_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RaceStandingsModel {
  String? raceName;
  bool? isEditable;
  List<RaceStandingsClassesModel?>? classes;

  RaceStandingsModel({this.raceName, this.isEditable, required this.classes});

  factory RaceStandingsModel.fromJson(Map<String, dynamic> json) =>
      _$RaceStandingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceStandingsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RaceStandingsClassesModel {
  String? className;
  List<RaceStandingsSessionModel?>? sessions;

  RaceStandingsClassesModel({required this.className, required this.sessions});

  factory RaceStandingsClassesModel.fromJson(Map<String, dynamic> json) =>
      _$RaceStandingsClassesModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceStandingsClassesModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RaceStandingsSessionModel {
  late int? sessionIndex;
  late SessionType? type;
  late List<RaceStandingsSummaryModel>? standings;

  RaceStandingsSessionModel({
    required this.sessionIndex,
    required this.type,
    required this.standings,
  });

  factory RaceStandingsSessionModel.fromJson(Map<String, dynamic> json) =>
      _$RaceStandingsSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceStandingsSessionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RaceStandingsSummaryModel {
  late UserModel? user;
  late TeamModel? team;
  late SummaryModel? summary;
  late ClassesModel? classs;

  RaceStandingsSummaryModel({
    required this.user,
    required this.summary,
    required this.team,
    required this.classs,
  });

  factory RaceStandingsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$RaceStandingsSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceStandingsSummaryModelToJson(this);
}
