// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_membership_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueMembershipModel _$LeagueMembershipModelFromJson(
        Map<String, dynamic> json) =>
    LeagueMembershipModel(
      id: json['_id'] as String?,
      memberId: json['memberId'] as String?,
      since: json['since'] == null
          ? null
          : DateTime.parse(json['since'] as String),
    );

Map<String, dynamic> _$LeagueMembershipModelToJson(
        LeagueMembershipModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'memberId': instance.memberId,
      'since': instance.since?.toIso8601String(),
    };
