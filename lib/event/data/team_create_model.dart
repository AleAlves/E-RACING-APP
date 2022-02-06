
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_create_model.g.dart';

@JsonSerializable()
class TeamCreateModel {
  late String? eventId;
  late TeamModel team;

  TeamCreateModel({required this.eventId, required this.team});

  factory TeamCreateModel.fromJson(Map<String, dynamic> json) => _$TeamCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamCreateModelToJson(this);
}