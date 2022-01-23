// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['_id'] as int?,
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : TeamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: $enumDecodeNullable(_$EventTypeEnumMap, json['type']),
      hour: json['hour'] as String?,
      races: (json['races'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : RaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rules: json['rules'] as String?,
      title: json['title'] as String?,
      state: $enumDecodeNullable(_$EventStateEnumMap, json['state']),
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
      'type': _$EventTypeEnumMap[instance.type],
      'state': _$EventStateEnumMap[instance.state],
      'teamsEnabled': instance.teamsEnabled,
      'broadcasting': instance.broadcasting,
      'scoring': instance.scoring,
      'races': instance.races,
      'teams': instance.teams,
      'attenders': instance.attenders,
      'settings': instance.settings,
    };

const _$EventTypeEnumMap = {
  EventType.race: 'race',
  EventType.championship: 'championship',
  EventType.error: 'error',
};

const _$EventStateEnumMap = {
  EventState.idle: 'idle',
  EventState.ongoing: 'ongoing',
  EventState.finished: 'finished',
};
