import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel {
  final String? message;
  final String? action;
  final bool? error;
  final dynamic next;
  final dynamic previous;

  StatusModel({required this.message, required this.action, required this.next, this.previous, this.error = false});

  factory StatusModel.fromJson(Map<String, dynamic> json) => _$StatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
