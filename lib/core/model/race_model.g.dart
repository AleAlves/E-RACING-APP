// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RaceModel _$RaceModelFromJson(Map<String, dynamic> json) => RaceModel(
      date: json['date'] as String?,
      title: json['title'] as String?,
      hour: json['hour'] as String?,
      finished: json['finished'] as bool?,
      id: json['_id'] as String?,
      notes: json['notes'] as String?,
      entries: (json['entries'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : EntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      settings: (json['settings'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SettingsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      broadcasting: json['broadcasting'] as bool?,
      broadcastLink: json['broadcastLink'] as String?,
    );

Map<String, dynamic> _$RaceModelToJson(RaceModel instance) => <String, dynamic>{
      '_id': instance.id,
      'date': instance.date,
      'hour': instance.hour,
      'title': instance.title,
      'notes': instance.notes,
      'finished': instance.finished,
      'broadcasting': instance.broadcasting,
      'broadcastLink': instance.broadcastLink,
      'entries': instance.entries,
      'settings': instance.settings,
    };
