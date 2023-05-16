import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/home/HomeRouter.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/service/api_exception.dart';
import '../../../core/tools/crypto/crypto_service.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/data/model/login_response.dart';
import '../../legacy/domain/model/public_key_model.dart';
import '../../legacy/domain/model/user_model.dart';
import '../../legacy/domain/usecase/get_public_key_usecase.dart';
import '../../legacy/domain/usecase/get_user_usecase.dart';
import '../../legacy/domain/usecase/save_user_usecase.dart';
import '../domain/sign_in_usecase.dart';
import 'navigation/login_sign_in_navigation.dart';

part 'login_sign_in_view_model.g.dart';

class LoginSignInViewModel = _LoginSignInViewModel with _$LoginSignInViewModel;

abstract class _LoginSignInViewModel
    extends BaseViewModel<LoginSignInNavigationSet> with Store {
  _LoginSignInViewModel();

  @override
  @observable
  LoginSignInNavigationSet? flow = LoginSignInNavigationSet.home;

  @override
  @observable
  ViewState state = ViewState.ready;

  @observable
  UserModel? user;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "";

  @observable
  String? errorMessage = "";

  @observable
  bool loginAutomatically = true;

  final _publicKeyUseCase = Modular.get<GetPublicKeyUseCase<PublicKeyModel>>();
  final _getUserUseCase = Modular.get<GetUserUseCase<UserModel?>>();
  final _signInUseCase = Modular.get<SignInUseCase<LoginResponse>>();
  final _saveUserUseCase = Modular.get<SaveUserUseCase>();

  void getPublicKey() async {
    state = ViewState.loading;
    await _publicKeyUseCase.invoke(
        success: (response) {
          Session.instance
              .setKeyChain(CryptoService.instance.generateAESKeys());
          Session.instance.setRSAKey(response);
          getUser();
        },
        failure: onError);
  }

  login(String email, String password) async {
    state = ViewState.loading;
    errorMessage = "";
    await _signInUseCase.params(email: email, password: password).invoke(
        success: (data) {
          Session.instance.setBearerToken(data.bearerToken);
          Session.instance.setUser(data.user);
          saveUser(email, password);
          if (data.required2FA) {
            // flow = LoginWidgetFlow.login2fa;
          } else {
            if (Session.instance.onDeeplinkFlow()) {
              Session.instance.setOnDeeplinkFlow(false);
              Modular.to.pushNamed(Session.instance.getDeeplink() ?? '');
            } else {
              Modular.to.pushNamed(HomeRouter.main);
            }
          }
        },
        failure: onLoginFailure);
  }

  void onLoginFailure(ApiException route) {
    errorMessage = route.message;
    state = ViewState.ready;
  }

  saveUser(String email, String password) async {
    await _saveUserUseCase
        .params(email: email, password: password)
        .invoke(success: (data) {}, failure: onError);
  }

  void getUser() async {
    state = ViewState.loading;
    await _getUserUseCase.invoke(
        success: (data) {
          if (data != null && loginAutomatically) {
            user = data;
            state = ViewState.loading;
            login(data.profile?.email ?? '', data.auth?.password ?? '');
          } else {
            state = ViewState.ready;
          }
        },
        failure: onError);
  }
}
