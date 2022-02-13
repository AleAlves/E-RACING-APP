// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassesModel _$ClassesModelFromJson(Map<String, dynamic> json) => ClassesModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      maxEntries: json['maxEntries'] as int?,
      drivers: (json['drivers'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : DriverModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClassesModelToJson(ClassesModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'maxEntries': instance.maxEntries,
      'drivers': instance.drivers,
    };
