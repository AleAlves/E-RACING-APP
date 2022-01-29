// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RaceModel _$RaceModelFromJson(Map<String, dynamic> json) => RaceModel(
      id: json['_id'] as String?,
      date: json['date'] as String?,
      notes: json['notes'] as String?,
      title: json['title'] as String?,
      position: json['position'] as int?,
      finished: json['finished'] as bool?,
      pilotId: json['pilotId'] as String?,
      broadcasting: json['broadcasting'] as bool?,
      entries: (json['entries'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : EntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      settings: (json['settings'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SettingsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..hour = json['hour'] as String?;

Map<String, dynamic> _$RaceModelToJson(RaceModel instance) => <String, dynamic>{
      '_id': instance.id,
      'date': instance.date,
      'hour': instance.hour,
      'title': instance.title,
      'notes': instance.notes,
      'position': instance.position,
      'finished': instance.finished,
      'pilotId': instance.pilotId,
      'broadcasting': instance.broadcasting,
      'entries': instance.entries,
      'settings': instance.settings,
    };
