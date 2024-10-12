import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileModel {
  final String? email;
  final String? firstName;
  final String? surName;
  final String? country;
  final List<String?>? tags;

  ProfileModel(
      {this.email, this.firstName, this.surName, this.country, this.tags});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
