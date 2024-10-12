import 'package:json_annotation/json_annotation.dart';

part 'media_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MediaModel {
  late String? image;
  late String? url;
  late String? origin;

  MediaModel(this.image, {this.url, this.origin});

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);
}
