import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entry_model.dart';

part 'session_model.g.dart';

enum SessionType { warmup, practice, qualify, race }

@JsonSerializable()
class SessionModel {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? raceId;
  SessionType? type;
  List<SettingsModel?>? settings;
  List<EntryModel?>? entries;

  SessionModel({
    this.raceId,
    this.name,
    this.type,
    this.id,
    this.settings,
    this.entries
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
