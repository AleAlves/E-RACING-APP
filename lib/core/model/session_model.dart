import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_model.g.dart';

enum SessionType { warmup, practice, qualify, race }

@JsonSerializable()
class SessionModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? raceId;
  final SessionType? type;
  final List<SettingsModel?>? settings;

  SessionModel({
    this.raceId,
    this.type,
    this.id,
    this.settings,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
