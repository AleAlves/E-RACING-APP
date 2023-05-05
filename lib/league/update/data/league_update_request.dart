import 'package:json_annotation/json_annotation.dart';

import '../../../core/model/media_model.dart';
import '../../list/data/league_model.dart';

part 'league_update_request.g.dart';

@JsonSerializable()
class LeagueUpdateRequest {
  late LeagueModel league;
  late MediaModel media;

  LeagueUpdateRequest(this.league, this.media);

  factory LeagueUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$LeagueUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueUpdateRequestToJson(this);
}
