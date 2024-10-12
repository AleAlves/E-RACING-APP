import 'package:json_annotation/json_annotation.dart';

part 'league_search_request.g.dart';

@JsonSerializable(explicitToJson: true)
class LeagueSearchRequest {
  late List<String>? tagIds;

  LeagueSearchRequest(this.tagIds);

  factory LeagueSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$LeagueSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueSearchRequestToJson(this);
}
