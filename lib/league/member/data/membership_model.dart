import 'package:json_annotation/json_annotation.dart';

part 'membership_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MembershipModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? memberId;
  final String? since;
  final bool? isManager;

  MembershipModel({this.id, this.memberId, this.since, this.isManager});

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipModelFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipModelToJson(this);
}
