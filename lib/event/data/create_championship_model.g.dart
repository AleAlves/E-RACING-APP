// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_championship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateChampionshipModel _$CreateChampionshipModelFromJson(
        Map<String, dynamic> json) =>
    CreateChampionshipModel(
      (json['medias'] as List<dynamic>)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      EventModel.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateChampionshipModelToJson(
        CreateChampionshipModel instance) =>
    <String, dynamic>{
      'medias': instance.medias,
      'event': instance.event,
    };
