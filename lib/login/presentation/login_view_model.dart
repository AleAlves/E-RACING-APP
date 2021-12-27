import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/domain/login_interactor.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:mobx/mobx.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModel with _$LoginViewModel;

abstract class _LoginViewModel with Store {
  _LoginViewModel();

  @observable
  ViewState state = ViewState.loading;

  @observable
  LoginFlow flow = LoginFlow.initial;

  @observable
  UserModel? user;

  @observable
  StatusModel? status;

  @observable
  String? otpQR;

  @observable
  bool loginAutomatically = true;

  final LoginInteractor _interactor = LoginInteractorImpl();

  void getPublickey() async {
    state = ViewState.loading;
    await _interactor.getPublicKey((key) {
      Session.instance.setRSAKey(key);
      Session.instance.setKeyChain(CryptoService.instance.generateAESKeys());
      getUser();
    }, onError);
  }

  void login(String email, String password) async {

    state = ViewState.loading;

    await _interactor.login(email, password, (login) {
      Session.instance.setBearerToken(login.bearerToken);
      saveUser(email, password);

      flow = LoginFlow.next;
      if (login.required2FA) {
        flow = LoginFlow.login2fa;
      } else {}
    }, onError);
  }

  void toogle2fa(bool value) async {

    state = ViewState.loading;

    await _interactor.toogle2FA((success) {
      state = ViewState.ready;
      var message = '';
      if (value) {
        message = "2FA habilitado";
      } else {
        message = "2FA desabilitado";
      }
      otpQR = success;
      status = StatusModel(message, "Ok", next: LoginFlow.otpQr);
      flow = LoginFlow.status;
    }, onError);
  }

  void login2fa(String code) async {
    state = ViewState.loading;

    await _interactor.login2FA(code, (success) {
      status =
          StatusModel("2FA Logged successfuly", "ok", next: LoginFlow.initial);
    }, onError);
  }

  void signin(String name, String surname, String mail, String password) async {
    state = ViewState.loading;

    await _interactor.signIn(name, surname, mail, password, () {
      state = ViewState.ready;
      status =
          StatusModel("Conta criada com sucesso", "Ok", next: LoginFlow.login);
      flow = LoginFlow.status;
    }, onError);
  }

  void forgot(String mail) async {
    state = ViewState.loading;
    await _interactor.forgot(mail, () {
      state = ViewState.ready;
      status = StatusModel(
          "Enviamos um código de verificação para o seu email ", "Ok",
          next: LoginFlow.reset);
      flow = LoginFlow.status;
    }, onError);
  }

  void reset(String mail, String password, String code) async {
    state = ViewState.loading;
    await _interactor.reset(mail, password, code, () {
      state = ViewState.ready;
      status = StatusModel("Senha resetada", "Ok", next: LoginFlow.login);
      flow = LoginFlow.status;
    }, onError);
  }

  void getUser() async {
    await _interactor.getUser(loadCurrentUser);
    state = ViewState.ready;
  }

  void loadCurrentUser(UserModel? userModel) {
    if (userModel != null) {
      flow = LoginFlow.login;
      user = userModel;
      if (loginAutomatically) {
        login(userModel.profile?.email ?? '', userModel.auth?.password ?? '');
      }
    }
  }

  void saveUser(String email, String password) async {
    await _interactor.saveUser(email, password);
  }

  void onError(ApiException error) {
    status = StatusModel(error.message(), "Ok",
        next: LoginFlow.initial, previous: flow);

    if (error.isBusiness()) {
      state = ViewState.ready;
      flow = LoginFlow.status;
    } else {
      state = ViewState.error;
    }
  }

  void retry() {
    state = ViewState.ready;
    flow = status?.previous ?? LoginFlow.initial;
  }
}
