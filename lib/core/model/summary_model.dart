
import 'package:json_annotation/json_annotation.dart';

part 'summary_model.g.dart';

@JsonSerializable()
class SummaryModel {
  final int? number;
  final int? laps;
  final int? bonus;
  final int? points;
  final int? penalty;
  final int? position;
  final String? notes;
  final String? pilotId;
  final int? fastestLapTime;
  final bool? disqualified;
  final bool? didntFinish;

  SummaryModel({
    required this.number,
    required this.laps,
    required this.bonus,
    required this.notes,
    required this.points,
    required this.penalty,
    required this.pilotId,
    required this.position,
    required this.disqualified,
    required this.didntFinish,
    required this.fastestLapTime,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryModelToJson(this);
}
