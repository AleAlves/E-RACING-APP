import 'package:e_racing_app/login/domain/model/bearer_token_model.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  BearerTokenModel bearerToken;
  bool required2FA;
  UserModel user;

  LoginResponse(
      {required this.user,
      required this.bearerToken,
      required this.required2FA});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
