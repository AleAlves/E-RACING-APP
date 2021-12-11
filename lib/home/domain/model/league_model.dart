import 'package:json_annotation/json_annotation.dart';

part 'league_model.g.dart';

@JsonSerializable()
class LeagueModel{
  final String? id;
  final String? owner;
  final String? name;
  final String? description;
  final List<String>? members;
  final int? capacity;

  LeagueModel(
      {this.id,
      this.owner,
      this.name,
      this.description,
      this.capacity,
      this.members});

  factory LeagueModel.fromJson(Map<String, dynamic> json) =>
      _$LeagueModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueModelToJson(this);
}
