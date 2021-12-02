import 'package:e_racing_app/core/service/http_response.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/data/login_repository.dart';
import 'package:e_racing_app/login/data/model/login_response.dart';

import 'model/auth_model.dart';
import 'model/profile_model.dart';
import 'model/public_key_model.dart';
import 'model/user_model.dart';

abstract class LoginInteractor {
  Future getPublicKey(
      Function(PublicKeyModel) success, Function(ApiException) error);

  Future login(String email, String password, Function(LoginResponse) success,
      Function(ApiException) error);

  Future login2FA(
      String otp, Function(UserModel) success, Function(ApiException) error);

  Future toogle2FA(Function(String) success, Function(ApiException) error);

  Future signIn(String name, String surname, String email, String password,
      Function() success, Function(ApiException) error);

  Future forgot(String email, Function() success, Function(ApiException) error);

  Future reset(String email, String password, String code, Function() success,
      Function(ApiException) error);

  Future getUser(Function(UserModel?) success);

  Future saveUser(String email, String password);

  Future deleteUser(Function() success);
}

class LoginInteractorImpl extends LoginInteractor {
  final repository = LoginRepository();

  @override
  Future getPublicKey(success, error) async {
    await repository.getPublicKey((response) {
      success(PublicKeyModel.fromJson(response.data));
    }, (responseError) {
      onError(error, responseError);
    });
  }

  @override
  Future login(String email, String password, Function(LoginResponse) success,
      Function(ApiException) error) async {
    await repository.login(email, CryptoService.instance.sha256(password),
        (response) {
      success(LoginResponse.fromJson(response.data));
    }, (responseError) {
      onError(error, responseError);
    });
  }

  @override
  Future login2FA(String otp, Function(UserModel) success,
      Function(ApiException) error) async {
    await repository.login2fa(
        otp, Session.instance.getBearerToken()?.token ?? '', (response) {
      success(UserModel.fromJson(response.data));
    }, (responseError) {
      onError(error, responseError);
    });
  }

  @override
  Future toogle2FA(
      Function(String) success, Function(ApiException) error) async {
    await repository.toogle2fa((response) {
      success(response.data);
    }, (responseError) {
      onError(error, responseError);
    });
  }

  @override
  Future signIn(String name, String surname, String email, String password,
      Function() success, Function(ApiException) error) async {
    var user = UserModel(
        auth: AuthModel(password: CryptoService.instance.sha256(password)),
        profile: ProfileModel(name: name, surname: surname, email: email));

    await repository.signIn(user, (response) async {
      success();
    }, (responseError) {
      onError(error, responseError);
    });
  }

  @override
  Future forgot(
      String email, Function() success, Function(ApiException) error) async {
    await repository.forgot(email, (response) async {
      success();
    }, (responseError) {
      onError(error, responseError);
    });
  }

  @override
  Future reset(String email, String password, String code, Function() success,
      Function(ApiException) error) async {
    await repository.reset(email, CryptoService.instance.sha256(password), code,
        (response) async {
      success();
    }, (responseError) {
      onError(error, responseError);
    });
  }

  @override
  Future deleteUser(Function() success) async {
    repository.deleteUser(success);
  }

  @override
  Future getUser(Function(UserModel?) success) async {
    repository.getUser(success);
  }

  @override
  Future saveUser(String email, String password) async {
    repository.saveUser(UserModel(
        profile: ProfileModel(email: email),
        auth: AuthModel(password: password)));
  }

  void onError(
      Function(ApiException) error, HTTPResponse<dynamic> responseError) {
    bool businessError = false;
    if (responseError.response?.code == 422) {
      businessError = true;
    }
    error(ApiException(responseError.response?.status,
        isBusinessError: businessError));
  }
}
