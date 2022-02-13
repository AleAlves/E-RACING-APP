// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_standings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventStandingsModel _$EventStandingsModelFromJson(Map<String, dynamic> json) =>
    EventStandingsModel(
      eventId: json['eventId'] as String,
      classes: (json['classes'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : EventStandingClassesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventStandingsModelToJson(
        EventStandingsModel instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'classes': instance.classes,
    };
