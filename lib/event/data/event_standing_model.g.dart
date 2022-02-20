// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_standing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventStandingModel _$EventStandingModelFromJson(Map<String, dynamic> json) =>
    EventStandingModel(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      dnf: json['dnf'] as int?,
      laps: json['laps'] as int?,
      wins: json['wins'] as int?,
      top5: json['top5'] as int?,
      top10: json['top10'] as int?,
      bonus: json['bonus'] as int?,
      points: json['points'] as int?,
      penalties: json['penalties'] as int?,
      desqualifies: json['desqualifies'] as int?,
      bestPosition: json['bestPosition'] as int?,
      worstPosition: json['worstPosition'] as int?,
    );

Map<String, dynamic> _$EventStandingModelToJson(EventStandingModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'dnf': instance.dnf,
      'laps': instance.laps,
      'wins': instance.wins,
      'top5': instance.top5,
      'top10': instance.top10,
      'bonus': instance.bonus,
      'points': instance.points,
      'penalties': instance.penalties,
      'desqualifies': instance.desqualifies,
      'bestPosition': instance.bestPosition,
      'worstPosition': instance.worstPosition,
    };
