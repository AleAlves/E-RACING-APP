import 'package:e_racing_app/core/model/link_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'league_membership_model.g.dart';

@JsonSerializable()
class LeagueMembershipModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? memberId;
  final DateTime? since;

  LeagueMembershipModel({this.id, this.memberId, this.since});

  factory LeagueMembershipModel.fromJson(Map<String, dynamic> json) =>
      _$LeagueMembershipModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueMembershipModelToJson(this);
}
