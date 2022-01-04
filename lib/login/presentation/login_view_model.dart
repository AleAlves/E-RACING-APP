import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/data/model/login_response.dart';
import 'package:e_racing_app/login/domain/forgot_password_usecase.dart';
import 'package:e_racing_app/login/domain/get_public_key_usecase.dart';
import 'package:e_racing_app/login/domain/get_user_usecase.dart';
import 'package:e_racing_app/login/domain/login_2fa_usecase.dart';
import 'package:e_racing_app/login/domain/login_usecase.dart';
import 'package:e_racing_app/login/domain/model/public_key_model.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:e_racing_app/login/domain/reset_password_usecase.dart';
import 'package:e_racing_app/login/domain/save_user_usecase.dart';
import 'package:e_racing_app/login/domain/sign_in_usecase.dart';
import 'package:e_racing_app/login/domain/toogle_2fa_usecase.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:mobx/mobx.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModel with _$LoginViewModel;

abstract class _LoginViewModel with Store {
  _LoginViewModel();

  @observable
  ViewState state = ViewState.loading;

  @observable
  LoginWidgetFlow flow = LoginWidgetFlow.init;

  @observable
  UserModel? user;

  @observable
  StatusModel? status;

  @observable
  String? otpQR;

  @observable
  bool loginAutomatically = true;

  void getPublickey() async {
    state = ViewState.loading;
    await GetPublicKeyUseCase<PublicKeyModel>().invoke(success: (response) {
      Session.instance.setKeyChain(CryptoService.instance.generateAESKeys());
      Session.instance.setRSAKey(response);
      getUser();
    }, error: () {
      state = ViewState.error;
    });
  }

  void login(String email, String password) async {
    state = ViewState.loading;
    await LoginUseCase<LoginResponse>(email, password).invoke(
        success: (data) {
          Session.instance.setBearerToken(data.bearerToken);
          saveUser(email, password);
          if (data.required2FA) {
            flow = LoginWidgetFlow.login2fa;
          } else {
            //flow = LoginWidgetFlow.next;
          }
        },
        error: onError);
  }

  void toogle2fa(bool value) async {
    state = ViewState.loading;
    Toogle2FAUseCase().invoke(
        success: (success) {
          state = ViewState.ready;
          var message = '';
          if (value) {
            message = "2FA habilitado";
          } else {
            message = "2FA desabilitado";
          }
          otpQR = success;
          status = StatusModel(message, "Ok", next: LoginWidgetFlow.otpQr);
          flow = LoginWidgetFlow.status;
        },
        error: onError);
  }

  void login2fa(String code) async {
    state = ViewState.loading;
    await Login2FAUseCase(code, Session.instance.getBearerToken()?.token ?? '')
        .invoke(
            success: (success) {
              status = StatusModel("2FA Logged successfuly", "ok", next: LoginWidgetFlow.init);
            },
            error: onError);
  }

  void signin(String name, String surname, String mail, String password) async {
    state = ViewState.loading;

    await SignInUseCase<bool>(name, surname, mail, password).invoke(
        success: (data) {
          state = ViewState.ready;
          status = StatusModel("Conta criada com sucesso", "Ok",
              next: LoginWidgetFlow.login);
          flow = LoginWidgetFlow.status;
        },
        error: onError);
  }

  void forgot(String mail) async {
    state = ViewState.loading;
    await ForgotPasswordUseCase(mail).invoke(
        success: (data) {
          state = ViewState.ready;
          status = StatusModel(
              "Enviamos um código de verificação para o seu email ", "Ok",
              next: LoginWidgetFlow.reset);
          flow = LoginWidgetFlow.status;
        },
        error: onError);
  }

  void reset(String mail, String password, String code) async {
    state = ViewState.loading;
    await ResetPasswordUseCase(code, mail, password).invoke(
        success: (data) {
          state = ViewState.ready;
          status = StatusModel("Senha resetada", "Ok", next: LoginWidgetFlow.login);
          flow = LoginWidgetFlow.status;
        },
        error: onError);
  }

  void getUser() async {
    state = ViewState.loading;
    await GetUserUseCase<UserModel?>().invoke(
        success: (data) {
          if (data != null) {
            user = data;
            if (loginAutomatically) {
              login(data.profile?.email ?? '', data.auth?.password ?? '');
            }
          }
          flow = LoginWidgetFlow.login;
        },
        error: onError);
  }

  void saveUser(String email, String password) async {
    await SaveUserUseCase(email, password)
        .invoke(success: (data) {}, error: onError);
  }

  void onError(ApiException error) {
    status = StatusModel(error.message(), "Ok", next: LoginWidgetFlow.init, previous: flow);

    if (error.isBusiness()) {
      state = ViewState.ready;
      flow = LoginWidgetFlow.status;
    } else {
      state = ViewState.error;
    }
  }

  void retry() {
    state = ViewState.ready;
    flow = status?.previous ?? LoginWidgetFlow.init;
  }
}
