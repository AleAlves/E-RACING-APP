// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetRequest _$ResetRequestFromJson(Map<String, dynamic> json) => ResetRequest(
      json['email'] as String,
      json['password'] as String,
      json['code'] as String,
    );

Map<String, dynamic> _$ResetRequestToJson(ResetRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'code': instance.code,
    };
