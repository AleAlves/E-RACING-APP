// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventHomeModel _$EventHomeModelFromJson(Map<String, dynamic> json) =>
    EventHomeModel(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      event: EventModel.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventHomeModelToJson(EventHomeModel instance) =>
    <String, dynamic>{
      'users': instance.users,
      'event': instance.event,
    };
