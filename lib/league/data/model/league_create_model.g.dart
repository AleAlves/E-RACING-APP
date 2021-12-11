// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueCreateModel _$LeagueCreateModelFromJson(Map<String, dynamic> json) =>
    LeagueCreateModel(
      MediaModel.fromJson(json['media'] as Map<String, dynamic>),
      LeagueModel.fromJson(json['league'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeagueCreateModelToJson(LeagueCreateModel instance) =>
    <String, dynamic>{
      'media': instance.media,
      'league': instance.league,
    };
