import 'package:json_annotation/json_annotation.dart';

import '../../home/domain/model/league_model.dart';

part 'league_create_model.g.dart';

@JsonSerializable()
class LeagueCreateModel {
  late LeagueModel league;

  LeagueCreateModel(this.league);

  factory LeagueCreateModel.fromJson(Map<String, dynamic> json) =>
      _$LeagueCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueCreateModelToJson(this);
}
