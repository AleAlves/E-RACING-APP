import 'package:e_racing_app/core/model/entry_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'race_model.g.dart';

@JsonSerializable()
class RaceModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? date;
  final String? hour;
  final String? title;
  final String? notes;
  final bool? finished;
  final bool? broadcasting;
  final String? broadcastLink;
  final List<EntryModel?>? entries;
  final List<SettingsModel?>? settings;

  RaceModel({
    required this.date,
    required this.title,
    required this.hour,
    this.finished,
    this.id,
    this.notes,
    this.entries,
    this.settings,
    this.broadcasting,
    this.broadcastLink,
  });

  factory RaceModel.fromJson(Map<String, dynamic> json) =>
      _$RaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceModelToJson(this);
}
