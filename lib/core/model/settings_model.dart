import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  String? name;
  String? value;

  SettingsModel({required this.name, required this.value});

  factory SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}