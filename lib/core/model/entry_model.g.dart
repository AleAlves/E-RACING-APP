// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryModel _$EntryModelFromJson(Map<String, dynamic> json) => EntryModel(
      raceId: json['raceId'] as String?,
      summary: json['summary'] == null
          ? null
          : SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EntryModelToJson(EntryModel instance) =>
    <String, dynamic>{
      'raceId': instance.raceId,
      'summary': instance.summary,
    };
