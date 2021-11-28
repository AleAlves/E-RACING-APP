// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      auth: json['auth'] == null
          ? null
          : AuthModel.fromJson(json['auth'] as Map<String, dynamic>),
      profile: json['profile'] == null
          ? null
          : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'auth': instance.auth,
      'profile': instance.profile,
    };
