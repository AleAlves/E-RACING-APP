import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';

import '../data/profile_update_request.dart';
import 'model/profile_model.dart';

class UpdateProfileUseCase<T> extends BaseUseCase<T> {
  late String _name;
  late String _surname;
  late String _country;
  late String? _picture;

  UpdateProfileUseCase<T> params({
    required String name,
    required String surname,
    required String country,
    required String? picture,
  }) {
    _name = name;
    _surname = surname;
    _country = country;
    _picture = picture;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var profile = ProfileModel(
        firstName: _name, surName: _surname, email: "", country: _country);
    var media = MediaModel(_picture);
    var request = HTTPRequesParams(
        data: ProfileUpdateRequest(profile: profile, picture: media),
        cypherSchema: CypherSchema.aes);
    var response = await super.remote(Request(
        endpoint: "api/v1/user/update/profile",
        verb: HTTPVerb.put,
        params: request));
    if (response.isSuccessfully) {
      success.call(UserModel.fromJson(response.data) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
