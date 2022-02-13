import 'package:e_racing_app/event/data/event_standing_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_standing_classes_model.g.dart';

@JsonSerializable()
class EventStandingClassesModel {
  late String className;
  late List<EventStandingModel?>? standings;

  EventStandingClassesModel({required this.className, required this.standings});

  factory EventStandingClassesModel.fromJson(Map<String, dynamic> json) =>
      _$EventStandingClassesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventStandingClassesModelToJson(this);
}
