import 'package:e_racing_app/core/model/link_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'league_model.g.dart';

@JsonSerializable()
class LeagueModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? owner;
  final String? name;
  final String? emblem;
  final String? description;
  final List<String?>? members;
  final List<String?>? tags;
  late List<LinkModel?>? links;
  final int? capacity;

  LeagueModel(
      {this.id,
      this.owner,
      this.tags,
      this.name,
      this.emblem,
      this.links,
      this.description,
      this.capacity,
      this.members});

  factory LeagueModel.fromJson(Map<String, dynamic> json) =>
      _$LeagueModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueModelToJson(this);
}
