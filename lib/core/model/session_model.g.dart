// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      raceId: json['raceId'] as String?,
      type: $enumDecodeNullable(_$SessionTypeEnumMap, json['type']),
      id: json['_id'] as String?,
      settings: (json['settings'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SettingsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'raceId': instance.raceId,
      'type': _$SessionTypeEnumMap[instance.type],
      'settings': instance.settings,
    };

const _$SessionTypeEnumMap = {
  SessionType.warmup: 'warmup',
  SessionType.practice: 'practice',
  SessionType.qualify: 'qualify',
  SessionType.race: 'race',
};
