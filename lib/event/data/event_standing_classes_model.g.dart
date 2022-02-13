// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_standing_classes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventStandingClassesModel _$EventStandingClassesModelFromJson(
        Map<String, dynamic> json) =>
    EventStandingClassesModel(
      className: json['className'] as String,
      standings: (json['standings'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : EventStandingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventStandingClassesModelToJson(
        EventStandingClassesModel instance) =>
    <String, dynamic>{
      'className': instance.className,
      'standings': instance.standings,
    };
