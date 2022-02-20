import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_standing_model.g.dart';

@JsonSerializable()
class EventStandingModel {
  late UserModel? user;
  late int? dnf;
  late int? laps;
  late int? wins;
  late int? top5;
  late int? top10;
  late int? bonus;
  late int? points;
  late int? penalties;
  late int? desqualifies;
  late int? bestPosition;
  late int? worstPosition;

  EventStandingModel({
    required this.user,
    required this.dnf,
    required this.laps,
    required this.wins,
    required this.top5,
    required this.top10,
    required this.bonus,
    required this.points,
    required this.penalties,
    required this.desqualifies,
    required this.bestPosition,
    required this.worstPosition
  });

  factory EventStandingModel.fromJson(Map<String, dynamic> json) =>
      _$EventStandingModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventStandingModelToJson(this);
}
