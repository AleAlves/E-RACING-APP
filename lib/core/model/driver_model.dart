
import 'package:json_annotation/json_annotation.dart';

part 'driver_model.g.dart';

@JsonSerializable()
class DriverModel {
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

  DriverModel({
    required this.number,
    required this.laps,
    required this.bonus,
    required this.notes,
    required this.points,
    required this.penalty,
    required this.pilotId,
    required this.position,
    required this.disqualified,
    required this.fastestLapTime,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);
}
