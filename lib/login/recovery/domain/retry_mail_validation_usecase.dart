import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/login_router.dart';

class RetryMailValidationUseCase<T> extends BaseUseCase<T> {
  late String _email;

  RetryMailValidationUseCase<T> params({required String email}) {
    _email = email;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/mail/resend/code",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(
            query: Pair("email", _email), cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      var status = StatusModel(
          message: "A new validation link was sent to your email",
          action: "Ok",
          route: LoginRouter.onboard);
      success.call(status as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
