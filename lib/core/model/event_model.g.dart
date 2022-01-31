// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['_id'] as String?,
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : TeamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      rules: json['rules'] as String?,
      title: json['title'] as String?,
      state: json['state'] as String?,
      hostId: json['hostId'] as String?,
      classes: (json['classes'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ClassesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      scoring:
          (json['scoring'] as List<dynamic>?)?.map((e) => e as int?).toList(),
      joinable: json['joinable'] as bool?,
      settings: (json['settings'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SettingsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      finished: json['finished'] as bool?,
      races: (json['races'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : RaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      membersOnly: json['membersOnly'] as bool?,
      teamsEnabled: json['teamsEnabled'] as bool?,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'rules': instance.rules,
      'finished': instance.finished,
      'joinable': instance.joinable,
      'hostId': instance.hostId,
      'type': instance.type,
      'state': instance.state,
      'teamsEnabled': instance.teamsEnabled,
      'membersOnly': instance.membersOnly,
      'scoring': instance.scoring,
      'races': instance.races,
      'teams': instance.teams,
      'classes': instance.classes,
      'settings': instance.settings,
    };
