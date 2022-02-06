import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

enum EventType { race, championship }

enum EventState { idle, ongoing, finished }

@JsonSerializable()
class EventModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? rules;
  final bool? finished;
  final bool? joinable;
  final String? hostId;
  final EventType? type;
  final EventState? state;
  final bool? teamsEnabled;
  final bool? membersOnly;
  final int? teamsMaxCrew;
  final List<int?>? scoring;
  final List<RaceModel?>? races;
  final List<TeamModel?>? teams;
  final List<ClassesModel?>? classes;
  final List<SettingsModel?>? settings;

  EventModel({
    this.id,
    this.teams,
    this.type,
    this.rules,
    this.title,
    this.state,
    this.hostId,
    this.classes,
    this.scoring,
    this.joinable,
    this.settings,
    this.finished,
    this.teamsMaxCrew,
    required this.races,
    required this.membersOnly,
    required this.teamsEnabled,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
