import 'package:e_racing_app/core/model/session_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/payment_model.dart';

part 'race_create_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RaceCreateModel {
  String? date;
  String? title;
  String? poster;
  String? leagueId;
  bool? broadcasting;
  bool? hasFee;
  String? broadcastLink;
  List<SessionModel?>? sessions;
  PaymentModel? payment;

  RaceCreateModel(
      {required this.date,
      required this.title,
      required this.broadcasting,
      this.poster,
      this.leagueId,
      this.sessions,
      this.broadcastLink,
      this.hasFee,
      this.payment});

  factory RaceCreateModel.fromJson(Map<String, dynamic> json) =>
      _$RaceCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaceCreateModelToJson(this);
}
