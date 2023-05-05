import 'package:e_racing_app/league/trophies/domain/model/participant_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'podium_model.g.dart';

@JsonSerializable()
class PodiumModel {
  @JsonKey(name: '_id')
  final String? id;

  @observable
  String? eventId;

  @observable
  String? className;

  @observable
  String? eventName;

  @observable
  ParticipantModel? firstPlace;

  @observable
  ParticipantModel? secondPlace;

  @observable
  ParticipantModel? thirdPlace;

  PodiumModel(
      {required this.id, required this.className, required this.eventName});

  factory PodiumModel.fromJson(Map<String, dynamic> json) =>
      _$PodiumModelFromJson(json);

  Map<String, dynamic> toJson() => _$PodiumModelToJson(this);
}
