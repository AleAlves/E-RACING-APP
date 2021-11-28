// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bearer_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BearerTokenModel _$BearerTokenModelFromJson(Map<String, dynamic> json) =>
    BearerTokenModel(
      json['token'] as String,
      json['scope'] as String,
    );

Map<String, dynamic> _$BearerTokenModelToJson(BearerTokenModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'scope': instance.scope,
    };
