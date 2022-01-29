import 'package:e_racing_app/core/model/entry_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'race_model.g.dart';

@JsonSerializable()
class RaceModel {
  @JsonKey(name: '_id')
  late String? id;
  late String? date;
  late String? hour;
  late String? title;
  late String? notes;
  late int? position;
  late bool? finished;
  late String? pilotId;
  late bool? broadcasting;
  late List<EntryModel?>? entries;
  late List<SettingsModel?>? settings;

  RaceModel({
    required this.id,
    required this.date,
    required this.notes,
    required this.title,
    required this.position,
    required this.finished,
    required this.pilotId,
    required this.broadcasting,
    required this.entries,
    required this.settings,
  });

  factory RaceModel.fromJson(Map<String, dynamic> json) =>
      _$RaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceModelToJson(this);
}
