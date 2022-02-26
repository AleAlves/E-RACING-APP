
import 'package:e_racing_app/league/domain/model/membership_model.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

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
