// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) => TeamModel(
      json['name'] as String?,
      (json['crew'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['points'] as int?,
    );

Map<String, dynamic> _$TeamModelToJson(TeamModel instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
      'crew': instance.crew,
    };
