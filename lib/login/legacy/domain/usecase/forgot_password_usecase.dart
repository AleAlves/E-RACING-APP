import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../../recovery/presentation/navigation/login_password_recovery_navigation.dart';

class ForgotPasswordUseCase<T> extends BaseUseCase<T> {
  late String _email;

  ForgotPasswordUseCase<T> params({required String email}) {
    _email = email;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/password/forgot",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(
            query: Pair("email", _email), cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      var status = StatusModel(
          message: "A new code was sent to your email",
          action: "Ok",
          externalLink: false,
          next: LoginPasswordRecoveryNavigationSet.reset);
      success.call(status as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
