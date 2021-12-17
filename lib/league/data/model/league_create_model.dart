import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'league_create_model.g.dart';

@JsonSerializable()
class LeagueCreateModel {
  late MediaModel media;
  late LeagueModel league;

  LeagueCreateModel(this.media, this.league);

  factory LeagueCreateModel.fromJson(Map<String, dynamic> json) => _$LeagueCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueCreateModelToJson(this);
}