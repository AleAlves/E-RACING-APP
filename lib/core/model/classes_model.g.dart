// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassesModel _$ClassesModelFromJson(Map<String, dynamic> json) => ClassesModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      maxEntries: json['maxEntries'] as int?,
      attenders: (json['attenders'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      entries: (json['entries'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : EntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClassesModelToJson(ClassesModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'maxEntries': instance.maxEntries,
      'entries': instance.entries,
      'attenders': instance.attenders,
    };
