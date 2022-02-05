// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      bearerToken: BearerTokenModel.fromJson(
          json['bearerToken'] as Map<String, dynamic>),
      required2FA: json['required2FA'] as bool,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'bearerToken': instance.bearerToken,
      'required2FA': instance.required2FA,
      'user': instance.user,
    };
