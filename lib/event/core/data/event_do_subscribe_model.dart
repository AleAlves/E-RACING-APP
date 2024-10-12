
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_do_subscribe_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EventDoSubscribeCreateModel {
  String classId;
  String eventId;

  EventDoSubscribeCreateModel({required this.classId, required this.eventId});

  factory EventDoSubscribeCreateModel.fromJson(Map<String, dynamic> json) => _$EventDoSubscribeCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventDoSubscribeCreateModelToJson(this);
}