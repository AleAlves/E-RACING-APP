
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_championship_model.g.dart';

@JsonSerializable()
class CreateChampionshipModel {
  late List<MediaModel> medias;
  late EventModel event;

  CreateChampionshipModel(this.medias, this.event);

  factory CreateChampionshipModel.fromJson(Map<String, dynamic> json) => _$CreateChampionshipModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateChampionshipModelToJson(this);
}