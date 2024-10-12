import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StatusModel {
  final String? message;
  final String? action;
  final bool? error;
  final dynamic route;

  StatusModel(
      {required this.message,
      required this.action,
      this.route,
      this.error = false});

  factory StatusModel.fromJson(Map<String, dynamic> json) =>
      _$StatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
