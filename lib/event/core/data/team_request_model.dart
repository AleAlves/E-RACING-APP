
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TeamRequestModel {
  late String? eventId;
  late String? teamId;

  TeamRequestModel({required this.eventId, required this.teamId});

  factory TeamRequestModel.fromJson(Map<String, dynamic> json) => _$TeamRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamRequestModelToJson(this);
}