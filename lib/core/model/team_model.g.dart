// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) => TeamModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      crew: (json['crew'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      points: json['points'] as int?,
    );

Map<String, dynamic> _$TeamModelToJson(TeamModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'points': instance.points,
      'crew': instance.crew,
    };
