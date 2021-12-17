import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'social_media_model.g.dart';

@JsonSerializable()
class SocialMediaModel {
  @JsonKey(name: '_id')
  final String? id;
  late String name;

  SocialMediaModel(this.id, this.name);

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) => _$SocialMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialMediaModelToJson(this);
}