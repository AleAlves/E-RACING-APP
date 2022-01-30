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
      hour: json['hour'] as String?,
      races: (json['races'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : RaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rules: json['rules'] as String?,
      title: json['title'] as String?,
      state: json['state'] as String?,
      hostId: json['hostId'] as String?,
      scoring:
          (json['scoring'] as List<dynamic>?)?.map((e) => e as int?).toList(),
      joinable: json['joinable'] as bool?,
      settings: (json['settings'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SettingsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      finished: json['finished'] as bool?,
      membersOnly: json['membersOnly'] as bool?,
      teamsEnabled: json['teamsEnabled'] as bool?,
      broadcasting: json['broadcasting'] as bool?,
    )..attenders = (json['attenders'] as List<dynamic>?)
        ?.map((e) => e as String?)
        .toList();

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'hour': instance.hour,
      'title': instance.title,
      'rules': instance.rules,
      'finished': instance.finished,
      'joinable': instance.joinable,
      'hostId': instance.hostId,
      'type': instance.type,
      'state': instance.state,
      'teamsEnabled': instance.teamsEnabled,
      'broadcasting': instance.broadcasting,
      'membersOnly': instance.membersOnly,
      'scoring': instance.scoring,
      'races': instance.races,
      'teams': instance.teams,
      'attenders': instance.attenders,
      'settings': instance.settings,
    };
