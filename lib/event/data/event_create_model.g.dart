// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCreateModel _$EventCreateModelFromJson(Map<String, dynamic> json) =>
    EventCreateModel(
      MediaModel.fromJson(json['media'] as Map<String, dynamic>),
      EventModel.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventCreateModelToJson(EventCreateModel instance) =>
    <String, dynamic>{
      'media': instance.media,
      'event': instance.event,
    };
