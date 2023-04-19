import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/legacy/domain/model/public_key_model.dart';

class GetPublicKeyUseCase<T> extends BaseUseCase<T> {
  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(
        Request(endpoint: "api/v1/auth/rsa/public-key", verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      var data = response.data == null
          ? error.call()
          : PublicKeyModel.fromJson(response.data) as T;
      success.call(data);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
