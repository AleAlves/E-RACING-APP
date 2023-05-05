import 'package:e_racing_app/core/model/session_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'race_create_model.g.dart';

@JsonSerializable()
class RaceCreateModel {
  String? date;
  String? title;
  String? poster;
  String? leagueId;
  bool? broadcasting;
  String? broadcastLink;
  List<SessionModel?>? sessions;

  RaceCreateModel({
    required this.date,
    required this.title,
    required this.broadcasting,
    this.poster,
    this.leagueId,
    this.sessions,
    this.broadcastLink,
  });

  factory RaceCreateModel.fromJson(Map<String, dynamic> json) =>
      _$RaceCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceCreateModelToJson(this);
}
