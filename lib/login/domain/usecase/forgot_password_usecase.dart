import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

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
        params: HTTPRequesParams(data: _email)));
    if (response.isSuccessfully) {
      var status = StatusModel(
          message: "Enviamos um código de verificação para o seu email ",
          action: "Ok",
          next: LoginWidgetFlow.reset);
      success.call(status as T);
    } else {
      error.call();
    }
  }
}
