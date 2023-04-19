
import 'package:json_annotation/json_annotation.dart';

part 'public_key_model.g.dart';

@JsonSerializable()
class PublicKeyModel {
  final String? publicKey;

  PublicKeyModel({this.publicKey});

  factory PublicKeyModel.fromJson(Map<String, dynamic> json) => _$PublicKeyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublicKeyModelToJson(this);
}