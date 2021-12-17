// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkModel _$LinkModelFromJson(Map<String, dynamic> json) => LinkModel(
      json['_id'] as String?,
      json['link'] as String,
      SocialMediaModel.fromJson(
          json['socialMediaModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinkModelToJson(LinkModel instance) => <String, dynamic>{
      '_id': instance.id,
      'link': instance.link,
      'socialMediaModel': instance.socialMediaModel,
    };
