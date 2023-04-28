import 'package:json_annotation/json_annotation.dart';

part 'share_model.g.dart';

@JsonSerializable()
class ShareModel {
  final String? eventId;
  final String? leagueId;
  final dynamic route;
  final String? message;
  final String? name;

  ShareModel(
      {required this.route,
      required this.leagueId,
      required this.message,
      required this.name,
      this.eventId});

  factory ShareModel.fromJson(Map<String, dynamic> json) =>
      _$ShareModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShareModelToJson(this);
}
