import 'package:e_racing_app/core/model/link_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'league_create_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LeagueCreateModel {
  final String? name;
  final String? banner;
  final String? description;
  final List<String?>? tags;
  late List<LinkModel?>? links;

  LeagueCreateModel(
      {this.tags, this.name, this.banner, this.links, this.description});

  factory LeagueCreateModel.fromJson(Map<String, dynamic> json) =>
      _$LeagueCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueCreateModelToJson(this);
}
