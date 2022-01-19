import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

class Toogle2FAUseCase<T> extends BaseUseCase<T> {
  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(
        Request(endpoint: "api/v1/auth/2fa/toogle", verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      var message = '';
      if (response.data) {
        message = "2FA habilitado";
      } else {
        message = "2FA desabilitado";
      }
      success.call(Pair<StatusModel, bool>(
          StatusModel(
              message: message, action: "Ok", next: LoginWidgetFlow.otpQr),
          response.data) as T);
    } else {
      error.call();
    }
  }
}