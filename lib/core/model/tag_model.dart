import 'package:json_annotation/json_annotation.dart';
part 'tag_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TagModel {
  @JsonKey(name: '_id')
  final String? id;
  late String name;
  TagModel(this.name, this.id);

  factory TagModel.fromJson(Map<String, dynamic> json) => _$TagModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}