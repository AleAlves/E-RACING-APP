import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';

import '../data/sign_up_model.dart';
import '../data/sign_up_request.dart';

class SignUpUseCase<T> extends BaseUseCase<T> {
  late String _name;
  late String _surname;
  late String _email;
  late String _password;
  late String _country;
  late List<String>? _tags;

  SignUpUseCase<T> params(
      {required String name,
      required String surname,
      required String email,
      required String password,
      required String country,
      required List<String> tags}) {
    _name = name;
    _surname = surname;
    _email = email;
    _password = password;
    _country = country;
    _tags = tags;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var signingUp = SignUpUserModel(
        name: _name,
        surname: _surname,
        email: _email,
        country: _country,
        tags: _tags,
        password: CryptoService.instance.sha256(_password),
        tokenFcm: Session.instance.getFCMToken());
    var request = HTTPRequesParams(
        data: SignUpRequest(signUp: signingUp), cypherSchema: CypherSchema.rsa);
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/signup", verb: HTTPVerb.post, params: request));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Account created\n now check your email to continue",
          action: "Ok",
          route: "") as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
