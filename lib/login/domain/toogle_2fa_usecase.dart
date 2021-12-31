import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/http_request.dart';

class Toogle2FAUseCase<T> extends BaseUseCase<T> {
  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(
        Request(endpoint: "api/v1/auth/2fa/toogle", verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      success.call(response.data as T);
    } else {
      error.call();
    }
  }
}
