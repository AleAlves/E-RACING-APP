import 'package:e_racing_app/core/service/api_service.dart';
import 'package:e_racing_app/core/service/base/base_service.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/tools/user_local_database.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';

import 'model/login_2fa_request.dart';
import 'model/login_request.dart';
import 'model/reset_request.dart';
import 'model/signin_request.dart';

abstract class LoginDataSource {
  Future getPublicKey(
      Function(HTTPResponse) success, Function(HTTPResponse) error);

  Future login(String email, String password, Function(HTTPResponse) success,
      Function(HTTPResponse) error);

  Future signIn(UserModel userModel, Function(HTTPResponse) success,
      Function(HTTPResponse) error);

  Future login2fa(String code, String token, Function(HTTPResponse) success,
      Function(HTTPResponse) error);

  Future forgot(String email, Function(HTTPResponse) success,
      Function(HTTPResponse) error);

  Future reset(String email, String password, String code,
      Function(HTTPResponse) success, Function(HTTPResponse) error);

  Future getUser(Function(UserModel?) success);

  Future saveUser(UserModel userModel);

  Future deleteUser(Function() success);
}

class LoginRepository extends LoginDataSource {
  final BaseService _service = ApiService();
  final UserLocalDatabase _userLocalDatabase = UserLocalDatabase();

  @override
  Future getPublicKey(
      Function(HTTPResponse) success, Function(HTTPResponse) error) async {
    await _service.getResponse(
        HTTPRequest(endpoint: "api/v1/auth/rsa/public-key", verb: HTTPVerb.get),
        success,
        error);
  }

  @override
  Future login(String email, String password, Function(HTTPResponse) success,
      Function(HTTPResponse) error) async {
    await _service.getResponse(
        HTTPRequest(
            endpoint: "api/v1/auth/login",
            verb: HTTPVerb.post,
            params: HTTPRequesParams(
                data: LoginRequest(
                    email, password, Session.instance.getKeyChain()!),
                safe: true,
                jsonEncoded: true,
                cypherSchema: CypherSchema.rsa)),
        success,
        error);
  }

  @override
  Future login2fa(String code, String token, Function(HTTPResponse) success,
      Function(HTTPResponse) error) async {
    await _service.getResponse(
        HTTPRequest(
            endpoint: "api/v1/auth/2fa/validate",
            verb: HTTPVerb.post,
            params: HTTPRequesParams(
                data: Login2FaRequest(code, token),
                safe: true,
                jsonEncoded: true,
                cypherSchema: CypherSchema.rsa)),
        success,
        error);
  }

  @override
  Future toogle2fa(
      Function(HTTPResponse) success, Function(HTTPResponse) error) async {
    await _service.getResponse(
        HTTPRequest(
            endpoint: "api/v1/auth/2fa/toogle",
            verb: HTTPVerb.get,
            params: HTTPRequesParams(safe: true, jsonEncoded: true)),
        success,
        error);
  }

  @override
  Future signIn(UserModel userModel, Function(HTTPResponse) success,
      Function(HTTPResponse) error) async {
    await _service.getResponse(
        HTTPRequest(
            endpoint: "api/v1/auth/signin",
            verb: HTTPVerb.post,
            params: HTTPRequesParams(
                data: SigninRequest(userModel),
                safe: true,
                jsonEncoded: true,
                cypherSchema: CypherSchema.rsa)),
        success,
        error);
  }

  @override
  Future forgot(String email, Function(HTTPResponse) success,
      Function(HTTPResponse) error) async {
    await _service.getResponse(
        HTTPRequest(
            endpoint: "api/v1/auth/password/forgot",
            verb: HTTPVerb.get,
            params:
                HTTPRequesParams(data: email, safe: false, jsonEncoded: false)),
        success,
        error);
  }

  @override
  Future reset(String email, String password, String code,
      Function(HTTPResponse) success, Function(HTTPResponse) error) async {
    await _service.getResponse(
        HTTPRequest(
            endpoint: "api/v1/auth/password/reset",
            verb: HTTPVerb.post,
            params: HTTPRequesParams(
                data: ResetRequest(email, password, code),
                safe: true,
                jsonEncoded: true,
                cypherSchema: CypherSchema.rsa)),
        success,
        error);
  }

  @override
  Future getUser(Function(UserModel?) success) async {
    success(await _userLocalDatabase.getUser());
  }

  @override
  Future saveUser(UserModel userModel) async {
    _userLocalDatabase.saveUser(userModel);
  }

  @override
  Future deleteUser(Function() success) async {
    _userLocalDatabase.deleteUser();
    success();
  }
}
