
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String? email;
  final String? name;
  final String? surname;
  final String? picture;
  final String? country;

  ProfileModel({this.email, this.name, this.surname, this.picture, this.country});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
