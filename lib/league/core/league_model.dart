import 'package:e_racing_app/core/model/link_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../member/data/membership_model.dart';

part 'league_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LeagueModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? owner;
  final String? name;
  final String? description;
  final List<MembershipModel?>? members;
  final List<String?>? tags;
  late List<LinkModel?>? links;
  final int? capacity;

  LeagueModel(
      {this.id,
      this.owner,
      this.tags,
      this.name,
      this.links,
      this.description,
      this.capacity,
      this.members});

  factory LeagueModel.fromJson(Map<String, dynamic> json) =>
      _$LeagueModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueModelToJson(this);
}
