// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryModel _$EntryModelFromJson(Map<String, dynamic> json) => EntryModel(
      raceId: json['raceId'] as String?,
      drivers: (json['drivers'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : DriverModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EntryModelToJson(EntryModel instance) =>
    <String, dynamic>{
      'raceId': instance.raceId,
      'drivers': instance.drivers,
    };
