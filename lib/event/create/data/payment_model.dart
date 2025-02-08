import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/event/core/data/event_create_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentModel {
  late String? value;
  late String? key;
  late String? notes;

  PaymentModel(this.value, this.key, this.notes);

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
