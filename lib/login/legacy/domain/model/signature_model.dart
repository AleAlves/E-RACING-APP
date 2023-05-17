import 'package:json_annotation/json_annotation.dart';

import 'level_model.dart';

part 'signature_model.g.dart';

@JsonSerializable()
class SignatureModel {
  @JsonKey(name: '_id')
  final String? id;
  final LevelModel? level;

  SignatureModel({this.id, this.level});

  factory SignatureModel.fromJson(Map<String, dynamic> json) =>
      _$SignatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureModelToJson(this);
}
