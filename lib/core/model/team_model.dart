import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable()
class TeamModel {
  String? name;
  int? points;
  List<String?>? crew;

  TeamModel({this.name, this.crew, this.points});

  factory TeamModel.fromJson(Map<String, dynamic> json) => _$TeamModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamModelToJson(this);
}