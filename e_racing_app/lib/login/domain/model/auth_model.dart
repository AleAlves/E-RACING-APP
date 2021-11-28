
import 'package:json_annotation/json_annotation.dart';
part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  final int? retries;
  final bool? mailValidated;
  final bool? is2FAEnabled;
  final String? mailCode;
  final String? password;
  final String? secret2FA;
  final String? passwordResetCode;

  AuthModel(
      {this.retries,
      this.mailValidated,
      this.mailCode,
      this.is2FAEnabled,
      this.password,
      this.passwordResetCode,
      this.secret2FA});

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
