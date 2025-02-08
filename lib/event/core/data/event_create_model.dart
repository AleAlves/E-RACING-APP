import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/model/event_model.dart';
import '../../create/data/payment_model.dart';

part 'event_create_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EventCreateModel {
  @JsonKey(name: '_id')
  String? id;
  EventInfoModel info;
  List<ClassesModel?>? classes;

  EventCreateModel({
    required this.info,
    required this.classes,
  });

  factory EventCreateModel.fromJson(Map<String, dynamic> json) =>
      _$EventCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventCreateModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EventInfoModel {
  String? hostLeagueId;
  String? title;
  String? rules;
  bool? finished;
  bool? isJoinable;
  bool? hasFee;
  EventType? type;
  String? leagueId;
  bool? isTeamsEnabled;
  bool? isForMembersOnly;
  int? maxTeamCrew;
  List<String?>? tags;
  List<int?>? scoring;
  List<SettingsModel?>? settings;
  PaymentModel? payment;

  EventInfoModel(
      {this.type,
      this.rules,
      this.settings,
      this.maxTeamCrew,
      this.payment,
      this.isJoinable,
      required this.title,
      required this.scoring,
      required this.tags,
      required this.hostLeagueId,
      required this.isForMembersOnly,
      required this.isTeamsEnabled,
      required this.hasFee});

  factory EventInfoModel.fromJson(Map<String, dynamic> json) =>
      _$EventInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventInfoModelToJson(this);
}
