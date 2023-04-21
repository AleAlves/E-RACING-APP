import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/login/legacy/data/model/login_request.dart';
import 'package:e_racing_app/login/legacy/data/model/login_response.dart';

class LoginUseCase<T> extends BaseUseCase<T> {
  late String _email;
  late String _password;

  LoginUseCase<T> params({required String email, required String password}) {
    _email = email;
    _password = password;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/login",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: LoginRequest(_email, CryptoService.instance.sha256(_password),
                Session.instance.getFCMToken(), Session.instance.getKeyChain()),
            cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      success.call(LoginResponse.fromJson(response.data) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
