// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) => DriverModel(
      number: json['number'] as int?,
      laps: json['laps'] as int?,
      bonus: json['bonus'] as int?,
      notes: json['notes'] as String?,
      points: json['points'] as int?,
      penalty: json['penalty'] as int?,
      pilotId: json['pilotId'] as String?,
      position: json['position'] as int?,
      disqualified: json['disqualified'] as bool?,
      fastestLapTime: json['fastestLapTime'] as int?,
    );

Map<String, dynamic> _$DriverModelToJson(DriverModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'laps': instance.laps,
      'bonus': instance.bonus,
      'points': instance.points,
      'penalty': instance.penalty,
      'position': instance.position,
      'notes': instance.notes,
      'pilotId': instance.pilotId,
      'fastestLapTime': instance.fastestLapTime,
      'disqualified': instance.disqualified,
    };
