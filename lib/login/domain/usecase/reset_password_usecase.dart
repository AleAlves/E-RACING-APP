import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/data/model/reset_request.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

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
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/password/reset",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: ResetRequest(_email, _password, _code),
            cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      var status = StatusModel(
          message: "Senha resetada", action: "Ok", next: LoginWidgetFlow.login);
      success.call(status as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
