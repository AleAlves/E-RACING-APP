// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      retries: json['retries'] as int?,
      mailValidated: json['mailValidated'] as bool?,
      mailCode: json['mailCode'] as String?,
      is2FAEnabled: json['is2FAEnabled'] as bool?,
      password: json['password'] as String?,
      passwordResetCode: json['passwordResetCode'] as String?,
      secret2FA: json['secret2FA'] as String?,
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'retries': instance.retries,
      'mailValidated': instance.mailValidated,
      'is2FAEnabled': instance.is2FAEnabled,
      'mailCode': instance.mailCode,
      'password': instance.password,
      'secret2FA': instance.secret2FA,
      'passwordResetCode': instance.passwordResetCode,
    };
