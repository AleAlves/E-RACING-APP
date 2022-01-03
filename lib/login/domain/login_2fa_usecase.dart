import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/login/data/model/login_2fa_request.dart';

import 'model/user_model.dart';

class Login2FAUseCase<T> extends BaseUseCase<T?> {
  final String _code;
  final String _token;

  Login2FAUseCase(this._code, this._token);

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/2fa/validate",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: Login2FaRequest(_code, _token),
            cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      var data =
          response.data == null ? null : UserModel.fromJson(response.data) as T;
      success.call(data);
    } else {
      error.call();
    }
  }
}
