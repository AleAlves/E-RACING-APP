import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable()
class TeamModel {
  @JsonKey(name: '_id')
  final String? id;
  String? name;
  String? creator;
  int? points;
  List<String?>? crew;

  TeamModel({this.id, this.name, this.creator, this.crew, this.points});

  factory TeamModel.fromJson(Map<String, dynamic> json) => _$TeamModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamModelToJson(this);
}