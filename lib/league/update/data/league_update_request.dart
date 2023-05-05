import 'package:e_racing_app/league/create/domain/model/league_create_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../list/data/league_model.dart';

part 'league_update_request.g.dart';

@JsonSerializable()
class LeagueUpdateRequest {
  late LeagueModel league;

  LeagueUpdateRequest(this.league);

  factory LeagueUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$LeagueUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueUpdateRequestToJson(this);
}
