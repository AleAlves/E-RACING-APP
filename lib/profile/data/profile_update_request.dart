import 'package:json_annotation/json_annotation.dart';

import '../../core/model/media_model.dart';
import '../domain/model/profile_model.dart';

part 'profile_update_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileUpdateRequest {
  late ProfileModel profile;
  late MediaModel picture;

  ProfileUpdateRequest({required this.profile, required this.picture});

  factory ProfileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUpdateRequestToJson(this);
}
