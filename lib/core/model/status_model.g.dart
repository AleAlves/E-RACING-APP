// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusModel _$StatusModelFromJson(Map<String, dynamic> json) => StatusModel(
      message: json['message'] as String?,
      action: json['action'] as String?,
      next: json['next'],
      previous: json['previous'],
      error: json['error'] as bool? ?? false,
    );

Map<String, dynamic> _$StatusModelToJson(StatusModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'action': instance.action,
      'error': instance.error,
      'next': instance.next,
      'previous': instance.previous,
    };
