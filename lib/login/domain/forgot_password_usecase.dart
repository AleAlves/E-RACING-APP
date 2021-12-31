import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/http_request.dart';

class ForgotPasswordUseCase<T> extends BaseUseCase<T> {
  final String _email;

  ForgotPasswordUseCase(this._email);

  @override
  Future<void> invoke(
      {required Function(T) success,
      required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/password/forgot",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(data: _email)));
    if (response.isSuccessfully) {
      success.call(response.data as T);
    } else {
      error.call();
    }
  }
}
