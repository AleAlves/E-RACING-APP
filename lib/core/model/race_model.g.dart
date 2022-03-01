// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RaceModel _$RaceModelFromJson(Map<String, dynamic> json) => RaceModel(
      date: json['date'] as String?,
      title: json['title'] as String?,
      broadcasting: json['broadcasting'] as bool?,
      id: json['_id'] as String?,
      poster: json['poster'] as String?,
      leagueId: json['leagueId'] as String?,
      sessions: (json['sessions'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      finished: json['finished'] as bool?,
      broadcastLink: json['broadcastLink'] as String?,
    );

Map<String, dynamic> _$RaceModelToJson(RaceModel instance) => <String, dynamic>{
      '_id': instance.id,
      'date': instance.date,
      'title': instance.title,
      'poster': instance.poster,
      'leagueId': instance.leagueId,
      'finished': instance.finished,
      'broadcasting': instance.broadcasting,
      'broadcastLink': instance.broadcastLink,
      'sessions': instance.sessions,
    };
