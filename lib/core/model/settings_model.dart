import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  late String? name;
  late String? value;

  SettingsModel(this.name, this.value);

  factory SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}