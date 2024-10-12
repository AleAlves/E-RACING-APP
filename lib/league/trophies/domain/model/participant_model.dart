import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../../../profile/domain/model/profile_model.dart';

part 'participant_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ParticipantModel {
  @JsonKey(name: '_id')
  final String? id;

  @observable
  String? driverId;

  @observable
  ProfileModel? profile;

  @observable
  String? points;

  ParticipantModel(
      {required this.id, required this.driverId, required this.points});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);
}
