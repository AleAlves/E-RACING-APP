
import 'package:json_annotation/json_annotation.dart';

part 'remove_subscription_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoveSubscriptionModel {
  String classId;
  String eventId;
  String userId;

  RemoveSubscriptionModel({required this.classId, required this.eventId, required this.userId});

  factory RemoveSubscriptionModel.fromJson(Map<String, dynamic> json) => _$RemoveSubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveSubscriptionModelToJson(this);
}