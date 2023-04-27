import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_model.g.dart';

@JsonSerializable()
class SummaryModel {
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

  SummaryModel({
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

  factory SummaryModel.fromJson(Map<String, dynamic> json) => _$SummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryModelToJson(this);
}
