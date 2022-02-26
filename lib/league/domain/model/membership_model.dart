import 'package:e_racing_app/core/model/link_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'membership_model.g.dart';

@JsonSerializable()
class MembershipModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? memberId;
  final String? since;

  MembershipModel({this.id, this.memberId, this.since});

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipModelFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipModelToJson(this);
}
