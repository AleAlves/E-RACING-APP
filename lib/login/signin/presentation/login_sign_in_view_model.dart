import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/tools/crypto/crypto_service.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/data/model/login_response.dart';
import '../../legacy/domain/model/public_key_model.dart';
import '../../legacy/domain/model/user_model.dart';
import '../../legacy/domain/usecase/get_public_key_usecase.dart';
import '../../legacy/domain/usecase/get_user_usecase.dart';
import '../../legacy/domain/usecase/save_user_usecase.dart';
import '../../legacy/domain/usecase/sign_in_usecase.dart';
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
  bool loginAutomatically = true;

  final publicKeyUseCase = Modular.get<GetPublicKeyUseCase<PublicKeyModel>>();
  final getUserUseCase = Modular.get<GetUserUseCase<UserModel?>>();
  final loginUseCase = Modular.get<LoginUseCase<LoginResponse>>();
  final saveUserUseCase = Modular.get<SaveUserUseCase>();

  void getPublicKey() async {
    state = ViewState.loading;
    await publicKeyUseCase.invoke(
        success: (response) {
          Session.instance
              .setKeyChain(CryptoService.instance.generateAESKeys());
          Session.instance.setRSAKey(response);
          getUser();
        },
        error: onError);
  }

  login(String email, String password) async {
    state = ViewState.loading;
    await loginUseCase.params(email: email, password: password).invoke(
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
              Modular.to.pushNamed(Routes.home);
            }
          }
        },
        error: onError);
  }

  saveUser(String email, String password) async {
    await saveUserUseCase
        .params(email: email, password: password)
        .invoke(success: (data) {}, error: onError);
  }

  void getUser() async {
    state = ViewState.loading;
    await getUserUseCase.invoke(
        success: (data) {
          if (data != null && loginAutomatically) {
            user = data;
            state = ViewState.loading;
            login(data.profile?.email ?? '', data.auth?.password ?? '');
          } else {
            state = ViewState.ready;
          }
        },
        error: onError);
  }
}
