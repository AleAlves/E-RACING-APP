import 'package:e_racing_app/core/model/social_media_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'link_model.g.dart';

@JsonSerializable()
class LinkModel {
  @JsonKey(name: '_id')
  final String? id;
  late String link;
  late SocialMediaModel socialMediaModel;

  LinkModel(this.id, this.link, this.socialMediaModel);

  factory LinkModel.fromJson(Map<String, dynamic> json) => _$LinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinkModelToJson(this);
}