import 'package:json_annotation/json_annotation.dart';

part 'login_2fa_request.g.dart';

@JsonSerializable()
class Login2FaRequest {
  String code;
  String token;

  Login2FaRequest(this.code, this.token);

  factory Login2FaRequest.fromJson(Map<String, dynamic> json) =>
      _$Login2FaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$Login2FaRequestToJson(this);
}
