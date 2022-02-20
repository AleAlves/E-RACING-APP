// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_standings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RaceStandingsModel _$RaceStandingsModelFromJson(Map<String, dynamic> json) =>
    RaceStandingsModel(
      raceClass: json['raceClass'] == null
          ? null
          : ClassesModel.fromJson(json['raceClass'] as Map<String, dynamic>),
      standings: (json['standings'] as List<dynamic>?)
          ?.map((e) =>
              RaceStandingsSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RaceStandingsModelToJson(RaceStandingsModel instance) =>
    <String, dynamic>{
      'raceClass': instance.raceClass,
      'standings': instance.standings,
    };
