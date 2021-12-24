import 'package:json_annotation/json_annotation.dart';
part 'social_platform_model.g.dart';

@JsonSerializable()
class SocialPlatformModel {
  @JsonKey(name: '_id')
  final String? id;
  late String name;

  SocialPlatformModel(this.id, this.name);

  factory SocialPlatformModel.fromJson(Map<String, dynamic> json) => _$SocialPlatformModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialPlatformModelToJson(this);
}