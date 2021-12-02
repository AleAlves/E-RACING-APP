// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusModel _$StatusModelFromJson(Map<String, dynamic> json) => StatusModel(
      json['message'] as String?,
      json['action'] as String?,
      next: $enumDecodeNullable(_$LoginFlowEnumMap, json['next']),
      previous: $enumDecodeNullable(_$LoginFlowEnumMap, json['previous']),
    );

Map<String, dynamic> _$StatusModelToJson(StatusModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'action': instance.action,
      'next': _$LoginFlowEnumMap[instance.next],
      'previous': _$LoginFlowEnumMap[instance.previous],
    };

const _$LoginFlowEnumMap = {
  LoginFlow.initial: 'initial',
  LoginFlow.login: 'login',
  LoginFlow.signin: 'signin',
  LoginFlow.login2fa: 'login2fa',
  LoginFlow.toogle2fa: 'toogle2fa',
  LoginFlow.otpQr: 'otpQr',
  LoginFlow.forgot: 'forgot',
  LoginFlow.mailRegistration: 'mailRegistration',
  LoginFlow.reset: 'reset',
  LoginFlow.resetCode: 'resetCode',
  LoginFlow.status: 'status',
};
