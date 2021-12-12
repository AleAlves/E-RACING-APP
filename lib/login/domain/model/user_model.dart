import 'package:json_annotation/json_annotation.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'auth_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String? id;
  final AuthModel? auth;
  final ProfileModel? profile;

  UserModel({this.id, this.auth, this.profile});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
