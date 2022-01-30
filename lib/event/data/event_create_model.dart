
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_create_model.g.dart';

@JsonSerializable()
class EventCreateModel {
  late MediaModel media;
  late EventModel event;

  EventCreateModel(this.media, this.event);

  factory EventCreateModel.fromJson(Map<String, dynamic> json) => _$EventCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventCreateModelToJson(this);
}