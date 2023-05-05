import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/event/create/domain/model/race_create_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/model/event_model.dart';

part 'event_create_model.g.dart';

@JsonSerializable()
class EventCreateModel {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? rules;
  bool? finished;
  bool? joinable;
  String? hostId;
  EventType? type;
  String? leagueId;
  bool? teamsEnabled;
  bool? membersOnly;
  int? teamsMaxCrew;
  List<String?>? tags;
  List<int?>? scoring;
  List<RaceCreateModel?>? races;
  List<TeamModel?>? teams;
  List<ClassesModel?>? classes;
  List<SettingsModel?>? settings;

  EventCreateModel({
    this.type,
    this.rules,
    this.settings,
    this.teamsMaxCrew,
    required this.title,
    required this.classes,
    required this.scoring,
    required this.tags,
    required this.leagueId,
    required this.races,
    required this.membersOnly,
    required this.teamsEnabled,
  });

  factory EventCreateModel.fromJson(Map<String, dynamic> json) =>
      _$EventCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventCreateModelToJson(this);
}
