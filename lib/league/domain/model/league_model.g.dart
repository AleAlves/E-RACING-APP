// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueModel _$LeagueModelFromJson(Map<String, dynamic> json) => LeagueModel(
      id: json['id'] as String?,
      owner: json['owner'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      capacity: json['capacity'] as int?,
      members:
          (json['members'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LeagueModelToJson(LeagueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner': instance.owner,
      'name': instance.name,
      'description': instance.description,
      'members': instance.members,
      'capacity': instance.capacity,
    };
