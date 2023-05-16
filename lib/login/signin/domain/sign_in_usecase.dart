import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/login/legacy/data/model/login_request.dart';
import 'package:e_racing_app/login/legacy/data/model/login_response.dart';

class SignInUseCase<T> extends BaseUseCase<T> {
  late String _email;
  late String _password;

  SignInUseCase<T> params({required String email, required String password}) {
    _email = email;
    _password = password;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/signin",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: LoginRequest(_email, CryptoService.instance.sha256(_password),
                Session.instance.getFCMToken(), Session.instance.getKeyChain()),
            cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      success.call(LoginResponse.fromJson(response.data) as T);
    } else {
      String? message;
      switch (response.response?.code) {
        case 400:
          message = "Invalid login";
          break;
        case 404:
          message = "Email or password invalid";
          break;
        case 422:
          message = "Email not validated";
          break;
      }
      failure.call(ApiException(message: message));
    }
  }
}
