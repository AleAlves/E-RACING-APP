import 'package:json_annotation/json_annotation.dart';
part 'link_model.g.dart';

@JsonSerializable()
class LinkModel {
  late String? platformId;
  late String? link;

  LinkModel(this.platformId, this.link);

  factory LinkModel.fromJson(Map<String, dynamic> json) => _$LinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinkModelToJson(this);
}