import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

enum EventType { race, championship, error }

enum EventState { idle, ongoing, finished }

@JsonSerializable()
class EventModel {
  @JsonKey(name: '_id')
  late String? id;
  late String? hour;
  late String? title;
  late String? rules;
  late bool? finished;
  late bool? joinable;
  late String? hostId;
  late String? type;
  late String? state;
  late bool? teamsEnabled;
  late bool? broadcasting;
  late List<int?>? scoring;
  late List<RaceModel?>? races;
  late List<TeamModel?>? teams;
  late List<String?>? attenders;
  late List<SettingsModel?>? settings;

  EventModel({
    required this.id,
    required this.teams,
    required this.type,
    required this.hour,
    required this.races,
    required this.rules,
    required this.title,
    required this.state,
    required this.hostId,
    required this.scoring,
    required this.joinable,
    required this.settings,
    required this.finished,
    required this.teamsEnabled,
    required this.broadcasting,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
