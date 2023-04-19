import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../domain/model/membership_model.dart';

part 'league_members_model.g.dart';

@JsonSerializable()
class LeagueMembersModel {
  late MembershipModel membership;
  late UserModel user;

  LeagueMembersModel(this.user, this.membership);

  factory LeagueMembersModel.fromJson(Map<String, dynamic> json) =>
      _$LeagueMembersModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueMembersModelToJson(this);
}
