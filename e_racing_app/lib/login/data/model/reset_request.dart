import 'package:json_annotation/json_annotation.dart';
part 'reset_request.g.dart';

@JsonSerializable()
class ResetRequest {
  late String email;
  late String password;
  late String code;

  ResetRequest(this.email, this.password, this.code);

  factory ResetRequest.fromJson(Map<String, dynamic> json) => _$ResetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetRequestToJson(this);
}