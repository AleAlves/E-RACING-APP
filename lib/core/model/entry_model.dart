import 'package:e_racing_app/core/model/summary_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel {
  String? raceId;
  SummaryModel? summary;

  EntryModel({required this.raceId, required this.summary});

  factory EntryModel.fromJson(Map<String, dynamic> json) =>
      _$EntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntryModelToJson(this);
}
