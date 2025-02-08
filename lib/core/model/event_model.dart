import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../event/core/data/event_create_model.dart';

part 'event_model.g.dart';

enum EventType { race, championship }

enum EventState { draft, ready, ongoing, finished }

@JsonSerializable(explicitToJson: true)
class EventModel {
  @JsonKey(name: '_id')
  String? id;
  EventType? type;
  EventState? state;
  EventInfoModel? info;
  List<ClassesModel?>? classes;
  List<RaceModel?>? races;
  List<TeamModel>? teams;

  EventModel(
      {this.id, this.type, this.races, this.teams, this.state, this.classes});

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
