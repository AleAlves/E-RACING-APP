import 'package:e_racing_app/core/model/summary_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entry_model.dart';

part 'driver_model.g.dart';

@JsonSerializable()
class DriverModel {
  String? driverId;
  List<EntryModel?>? entries;

  DriverModel({required this.driverId, required this.entries});

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);
}
