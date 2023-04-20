import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/login/legacy/data/model/signin_request.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/login_navigation.dart';

import '../model/auth_model.dart';
import '../model/profile_model.dart';
import '../model/user_model.dart';

class SignUpUseCase<T> extends BaseUseCase<T> {
  late String _name;
  late String _surname;
  late String _email;
  late String _password;
  late String _country;

  SignUpUseCase<T> params({
    required String name,
    required String surname,
    required String email,
    required String password,
    required String country,
  }) {
    _name = name;
    _surname = surname;
    _email = email;
    _password = password;
    _country = country;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var user = UserModel(
        tokenFcm: Session.instance.getFCMToken(),
        auth: AuthModel(password: CryptoService.instance.sha256(_password)),
        profile: ProfileModel(
            name: _name, surname: _surname, email: _email, country: _country));
    var request = HTTPRequesParams(
        data: SigninRequest(user: user), cypherSchema: CypherSchema.rsa);
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/signin", verb: HTTPVerb.post, params: request));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Account created, check your email to confirm it",
          action: "Ok",
          next: LoginWidgetFlow.login) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
