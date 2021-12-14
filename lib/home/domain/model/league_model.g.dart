// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueModel _$LeagueModelFromJson(Map<String, dynamic> json) => LeagueModel(
      id: json['_id'] as String?,
      owner: json['owner'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      name: json['name'] as String?,
      emblem: json['emblem'] as String?,
      description: json['description'] as String?,
      capacity: json['capacity'] as int?,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$LeagueModelToJson(LeagueModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'owner': instance.owner,
      'name': instance.name,
      'emblem': instance.emblem,
      'description': instance.description,
      'members': instance.members,
      'tags': instance.tags,
      'capacity': instance.capacity,
    };
