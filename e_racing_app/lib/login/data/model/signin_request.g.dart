// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninRequest _$SigninRequestFromJson(Map<String, dynamic> json) =>
    SigninRequest(
      UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SigninRequestToJson(SigninRequest instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
