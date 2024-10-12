import 'package:json_annotation/json_annotation.dart';

part 'level_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LevelModel {
  @JsonKey(name: '_id')
  final String? id;
  final bool? isManager;
  final int? maxLeagues;
  final int? maxEvents;
  final int? maxMembers;

  LevelModel(
      {this.id,
      this.isManager,
      this.maxLeagues,
      this.maxEvents,
      this.maxMembers});

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}
