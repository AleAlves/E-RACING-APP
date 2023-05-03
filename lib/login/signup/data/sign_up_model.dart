import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpUserModel {
  final String? email;
  final String? name;
  final String? surname;
  final String? country;
  final List<String?>? tags;
  final String? password;
  final String? tokenFcm;

  SignUpUserModel(
      {this.email,
      this.name,
      this.surname,
      this.country,
      this.tags,
      this.password,
      this.tokenFcm});

  factory SignUpUserModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpUserModelToJson(this);
}
