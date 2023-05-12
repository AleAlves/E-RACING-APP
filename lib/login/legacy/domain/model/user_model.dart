import 'package:e_racing_app/login/legacy/domain/model/signature_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../profile/domain/model/profile_model.dart';
import 'auth_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? tokenFcm;
  final AuthModel? auth;
  final ProfileModel? profile;
  final SignatureModel? signature;

  UserModel({this.id, this.tokenFcm, this.auth, this.profile, this.signature});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
