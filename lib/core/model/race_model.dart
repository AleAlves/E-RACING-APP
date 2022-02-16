import 'package:e_racing_app/core/model/session_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'race_model.g.dart';

@JsonSerializable()
class RaceModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? date;
  final String? title;
  final String? poster;
  final bool? finished;
  final bool? broadcasting;
  final String? broadcastLink;
  final List<SessionModel?>? sessions;


  RaceModel({
    required this.date,
    required this.title,
    required this.broadcasting,
    this.id,
    this.poster,
    this.sessions,
    this.finished,
    this.broadcastLink,
  });

  factory RaceModel.fromJson(Map<String, dynamic> json) =>
      _$RaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceModelToJson(this);
}
