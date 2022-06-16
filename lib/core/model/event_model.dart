import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

enum EventType { race, championship }

enum EventState { idle, ready, ongoing, finished }

@JsonSerializable()
class EventModel {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? rules;
  bool? finished;
  bool? joinable;
  String? hostId;
  EventType? type;
  String? leagueId;
  EventState? state;
  bool? teamsEnabled;
  bool? membersOnly;
  int? teamsMaxCrew;
  List<String?>? tags;
  List<int?>? scoring;
  List<RaceModel?>? races;
  List<TeamModel?>? teams;
  List<ClassesModel?>? classes;
  List<SettingsModel?>? settings;

  EventModel({
    this.id,
    this.teams,
    this.type,
    this.tags,
    this.rules,
    this.title,
    this.state,
    this.hostId,
    this.classes,
    this.scoring,
    this.joinable,
    this.settings,
    this.finished,
    this.leagueId,
    this.teamsMaxCrew,
    required this.races,
    required this.membersOnly,
    required this.teamsEnabled,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
