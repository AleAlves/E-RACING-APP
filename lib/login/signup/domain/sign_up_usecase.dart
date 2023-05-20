import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/login/login_router.dart';

import '../data/sign_up_model.dart';
import '../data/sign_up_request.dart';

class SignUpUseCase<T> extends BaseUseCase<T> {
  late String? _firstName;
  late String? _surName;
  late String? _email;
  late String? _password;
  late String? _country;
  late List<String?>? _tags;

  SignUpUseCase<T> params(
      {required String? firstName,
      required String? surName,
      required String? email,
      required String? password,
      required String? country,
      required List<String?>? tags}) {
    _firstName = firstName;
    _surName = surName;
    _email = email;
    _password = password;
    _country = country;
    _tags = tags;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var signingUp = SignUpUserModel(
        firstName: _firstName,
        surName: _surName,
        email: _email,
        country: _country,
        tags: _tags,
        password: _password,
        tokenFcm: Session.instance.getFCMToken());
    var request = HTTPRequesParams(
        data: SignUpRequest(signUp: signingUp), cypherSchema: CypherSchema.rsa);
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/signup", verb: HTTPVerb.post, params: request));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Account created.\n Now check your email to continue",
          action: "Ok",
          route: LoginRouter.signIn) as T);
    } else {
      var message = response.response?.code == 422
          ? "Email Already registered"
          : response.response?.status;
      failure.call(ApiException(message: message));
    }
  }
}
