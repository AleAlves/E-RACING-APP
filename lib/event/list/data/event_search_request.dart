import 'package:json_annotation/json_annotation.dart';

part 'event_search_request.g.dart';

@JsonSerializable(explicitToJson: true)
class EventSearchRequest {
  late List<String>? tagIds;

  EventSearchRequest(this.tagIds);

  factory EventSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$EventSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventSearchRequestToJson(this);
}
