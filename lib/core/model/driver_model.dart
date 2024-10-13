import 'package:json_annotation/json_annotation.dart';

part 'driver_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DriverModel {
  String? driverId;
  final bool? isFeePaid;
  final bool? isAccepted;

  DriverModel({
    required this.driverId,
    required this.isFeePaid,
    required this.isAccepted,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);
}
