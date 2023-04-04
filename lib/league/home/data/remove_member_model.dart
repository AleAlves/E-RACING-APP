import 'package:json_annotation/json_annotation.dart';

part 'remove_member_model.g.dart';

@JsonSerializable()
class RemoveMemberModel {
  late String leagueId;
  late String memberId;

  RemoveMemberModel(this.leagueId, this.memberId);

  factory RemoveMemberModel.fromJson(Map<String, dynamic> json) =>
      _$RemoveMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveMemberModelToJson(this);
}
