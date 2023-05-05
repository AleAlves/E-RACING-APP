import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/event/core/data/event_create_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_create_request.g.dart';

@JsonSerializable()
class EventCreateRequest {
  late String? leagueId;
  late EventCreateModel? event;
  late MediaModel? banner;

  EventCreateRequest(this.leagueId, this.event, this.banner);

  factory EventCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$EventCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventCreateRequestToJson(this);
}
