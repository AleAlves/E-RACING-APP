import 'package:json_annotation/json_annotation.dart';

part 'set_summary_model.g.dart';

@JsonSerializable()
class SetSummaryModel {
  late String? eventId;
  late String? classId;
  late String? raceId;
  late String? notes;
  late int? position;
  late int? penalty;
  late int? bonus;
  late bool? dnf;
  late bool? dqf;
  late int? lap;

  SetSummaryModel({
    this.position,
    this.penalty,
    this.eventId,
    this.classId,
    this.raceId,
    this.notes,
    this.bonus,
    this.dnf,
    this.dqf,
    this.lap
  });

  factory SetSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SetSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetSummaryModelToJson(this);
}
