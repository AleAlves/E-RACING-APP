import 'package:e_racing_app/core/model/session_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'race_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RaceModel {
  @JsonKey(name: '_id')
  String? id;
  String? date;
  String? title;
  String? leagueId;
  bool? finished;
  bool? canceled;
  bool? broadcasting;
  String? broadcastLink;
  List<SessionModel?>? sessions;

  RaceModel({
    required this.date,
    required this.title,
    required this.broadcasting,
    this.id,
    this.leagueId,
    this.sessions,
    this.finished,
    this.canceled,
    this.broadcastLink,
  });

  factory RaceModel.fromJson(Map<String, dynamic> json) =>
      _$RaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceModelToJson(this);
}
