import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel {
  late int? number;
  late int? laps;
  late int? bonus;
  late int? points;
  late int? penalty;
  late int? position;
  late String? notes;
  late String? pilotId;
  late int? fastesLapTime;
  late bool? disqualified;

  EntryModel({
    required this.number,
    required this.laps,
    required this.bonus,
    required this.notes,
    required this.points,
    required this.penalty,
    required this.pilotId,
    required this.position,
    required this.disqualified,
    required this.fastesLapTime,
  });

  factory EntryModel.fromJson(Map<String, dynamic> json) =>
      _$EntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntryModelToJson(this);
}
