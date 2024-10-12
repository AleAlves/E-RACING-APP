import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_home_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EventHomeModel {
  late List<UserModel?>? users;
  late EventModel event;

  EventHomeModel({required this.users, required this.event});

  factory EventHomeModel.fromJson(Map<String, dynamic> json) =>
      _$EventHomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventHomeModelToJson(this);
}
