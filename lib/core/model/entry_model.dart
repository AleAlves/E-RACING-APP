import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel {
  final int? number;
  final int? laps;
  final int? bonus;
  final int? points;
  final int? penalty;
  final int? position;
  final String? notes;
  final String? pilotId;
  final int? fastesLapTime;
  final bool? disqualified;

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
