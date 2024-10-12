import 'package:e_racing_app/login/signup/data/sign_up_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SignUpRequest {
  late SignUpUserModel signUp;

  SignUpRequest({required this.signUp});

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}
