import 'package:json_annotation/json_annotation.dart';

import 'driver_model.dart';

part 'classes_model.g.dart';

@JsonSerializable()
class ClassesModel {
  @JsonKey(name: '_id')
  final String? id;
  String? name;
  int? maxEntries;
  List<DriverModel?>? drivers;

  ClassesModel(
      {this.id,
      required this.name,
      this.maxEntries,
      this.drivers});

  factory ClassesModel.fromJson(Map<String, dynamic> json) =>
      _$ClassesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClassesModelToJson(this);
}
