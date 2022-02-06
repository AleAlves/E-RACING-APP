// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamCreateModel _$TeamCreateModelFromJson(Map<String, dynamic> json) =>
    TeamCreateModel(
      eventId: json['eventId'] as String?,
      team: TeamModel.fromJson(json['team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamCreateModelToJson(TeamCreateModel instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'team': instance.team,
    };
