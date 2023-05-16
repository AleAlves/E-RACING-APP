import 'package:json_annotation/json_annotation.dart';

part 'signature_model.g.dart';

@JsonSerializable()
class SignatureModel {
  @JsonKey(name: '_id')
  final String? id;
  final bool? isManager;
  final int? maxGroups;
  final int? maxLeagues;
  final int? maxEvents;
  final int? maxMembers;

  SignatureModel(
      {this.id,
      this.isManager,
      this.maxGroups,
      this.maxLeagues,
      this.maxEvents,
      this.maxMembers});

  factory SignatureModel.fromJson(Map<String, dynamic> json) =>
      _$SignatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureModelToJson(this);
}
