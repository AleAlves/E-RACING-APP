import 'package:json_annotation/json_annotation.dart';
part 'bearer_token_model.g.dart';


@JsonSerializable()
class BearerTokenModel  {
  late String token;
  late String scope;

  BearerTokenModel(this.token, this.scope);

  factory BearerTokenModel.fromJson(Map<String, dynamic> json) => _$BearerTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$BearerTokenModelToJson(this);
}
