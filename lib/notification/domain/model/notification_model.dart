import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

enum NotificationTypeModel { race, event, league,profile  }

@JsonSerializable()
class NotificationModel {
  late String? date;
  late String message;
  late bool important;
  late bool hasAction;
  late List<NotificationSourceModel> source;

  NotificationModel(
      {required this.date,
      required this.message,
      required this.important,
      required this.hasAction});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class NotificationSourceModel {
  late String? sourceId;
  late NotificationTypeModel type;

  NotificationSourceModel({required this.sourceId, required this.type});

  factory NotificationSourceModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSourceModelToJson(this);
}
