import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/legacy/data/model/reset_request.dart';
import 'package:e_racing_app/login/login_router.dart';

import '../../../../core/tools/crypto/crypto_service.dart';

class ResetPasswordUseCase<T> extends BaseUseCase<T> {
  late String _code;
  late String _email;
  late String _password;

  ResetPasswordUseCase<T> params(
      {required String code, required String email, required String password}) {
    _code = code;
    _email = email;
    _password = password;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/password/reset",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: ResetRequest(
                _email, CryptoService.instance.sha256(_password), _code),
            cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      var status = StatusModel(
          message: "Password reseted", action: "Ok", route: LoginRouter.signIn);
      success.call(status as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
