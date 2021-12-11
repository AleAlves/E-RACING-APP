import 'package:json_annotation/json_annotation.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel {
  final String? message;
  final String? action;
  final dynamic next;
  final dynamic previous;

  StatusModel(this.message, this.action, {this.next, this.previous});

  factory StatusModel.fromJson(Map<String, dynamic> json) => _$StatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
