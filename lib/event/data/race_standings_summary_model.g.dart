// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_standings_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RaceStandingsSummaryModel _$RaceStandingsSummaryModelFromJson(
        Map<String, dynamic> json) =>
    RaceStandingsSummaryModel(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      summary: json['summary'] == null
          ? null
          : SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
      team: json['team'] == null
          ? null
          : TeamModel.fromJson(json['team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RaceStandingsSummaryModelToJson(
        RaceStandingsSummaryModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'team': instance.team,
      'summary': instance.summary,
    };
