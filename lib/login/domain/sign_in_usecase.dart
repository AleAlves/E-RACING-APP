import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/login/data/model/login_2fa_request.dart';
import 'package:e_racing_app/login/data/model/signin_request.dart';

import 'model/auth_model.dart';
import 'model/profile_model.dart';
import 'model/user_model.dart';

class SignInUseCase<T> extends BaseUseCase<T> {
  final String _name;
  final String _surname;
  final String _email;
  final String _password;

  SignInUseCase(this._name, this._surname, this._email, this._password);

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var user = UserModel(
        auth: AuthModel(password: CryptoService.instance.sha256(_password)),
        profile: ProfileModel(name: _name, surname: _surname, email: _email));
    var response = await super.remote(Request(
        endpoint: "api/v1/auth/signin",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: SigninRequest(user), cypherSchema: CypherSchema.rsa)));
    if (response.isSuccessfully) {
      success.call(UserModel.fromJson(response.data) as T);
    } else {
      error.call();
    }
  }
}
