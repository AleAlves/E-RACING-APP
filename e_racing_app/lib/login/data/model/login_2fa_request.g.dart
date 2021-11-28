// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_2fa_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login2FaRequest _$Login2FaRequestFromJson(Map<String, dynamic> json) =>
    Login2FaRequest(
      json['code'] as String,
      json['token'] as String,
    );

Map<String, dynamic> _$Login2FaRequestToJson(Login2FaRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'token': instance.token,
    };
