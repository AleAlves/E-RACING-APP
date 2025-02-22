import 'package:e_racing_app/login/legacy/domain/model/keychain_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginRequest {
  late String email;
  late String password;
  late String? tokenFcm;
  late KeyChainModel keyChain;

  LoginRequest(this.email, this.password, this.tokenFcm, this.keyChain);

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}