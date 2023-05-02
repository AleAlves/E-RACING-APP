import 'package:e_racing_app/core/model/race_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_race_model.g.dart';

@JsonSerializable()
class UpdateRaceModel {
  late String? eventId;
  late RaceModel? raceModel;

  UpdateRaceModel({this.eventId, this.raceModel});

  factory UpdateRaceModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateRaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRaceModelToJson(this);
}
