import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/legacy/data/model/login_2fa_request.dart';

import '../model/user_model.dart';

class Login2FAUseCase<T> extends BaseUseCase<T?> {
  late String _code;
  late String _token;

  Login2FAUseCase<T> params({required String code, required String token}) {
    _code = code;
    _token = token;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/2fa/validate",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: Login2FaRequest(_code, _token),
            cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      var data =
          response.data == null ? null : UserModel.fromJson(response.data) as T;
      var wow = StatusModel(
          message: "2FA Logged successfuly", action: "ok", route: "");
      success.call(wow as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
