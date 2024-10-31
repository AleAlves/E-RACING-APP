import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_update_request.g.dart';

@JsonSerializable(explicitToJson: true)
class EventUpdateRequest {
  late String? leagueId;
  late EventModel? event;
  late MediaModel? banner;

  EventUpdateRequest(this.leagueId, this.event, this.banner);

  factory EventUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$EventUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventUpdateRequestToJson(this);
}
