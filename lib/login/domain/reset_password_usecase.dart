import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/login/data/model/reset_request.dart';

class ResetPasswordUseCase<T> extends BaseUseCase<T> {
  final String _code;
  final String _email;
  final String _password;

  ResetPasswordUseCase(this._code, this._email, this._password);

  @override
  Future<void> invoke(
      {required Function(T) success,
      required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/password/reset",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: ResetRequest(_email, _password, _code),
            cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      success.call(response.data as T);
    } else {
      error.call();
    }
  }
}
