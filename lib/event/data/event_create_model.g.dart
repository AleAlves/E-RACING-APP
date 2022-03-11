// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCreateModel _$EventCreateModelFromJson(Map<String, dynamic> json) =>
    EventCreateModel(
      json['media'] == null
          ? null
          : MediaModel.fromJson(json['media'] as Map<String, dynamic>),
      json['event'] == null
          ? null
          : EventModel.fromJson(json['event'] as Map<String, dynamic>),
      json['leagueId'] as String?,
    );

Map<String, dynamic> _$EventCreateModelToJson(EventCreateModel instance) =>
    <String, dynamic>{
      'media': instance.media,
      'event': instance.event,
      'leagueId': instance.leagueId,
    };
