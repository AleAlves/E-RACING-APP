import 'package:e_racing_app/league/create/domain/model/league_create_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'league_create_request.g.dart';

@JsonSerializable()
class LeagueCreateRequest {
  late LeagueCreateModel league;

  LeagueCreateRequest(this.league);

  factory LeagueCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$LeagueCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueCreateRequestToJson(this);
}
