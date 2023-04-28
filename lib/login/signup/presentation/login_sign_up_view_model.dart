import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/tools/crypto/crypto_service.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/public_key_model.dart';
import '../../legacy/domain/usecase/get_public_key_usecase.dart';
import '../../legacy/domain/usecase/sign_up_usecase.dart';
import 'navigation/login_sign_up_navigation.dart';

part 'login_sign_up_view_model.g.dart';

class LoginSignUpViewModel = _LoginSignUpViewModel with _$LoginSignUpViewModel;

abstract class _LoginSignUpViewModel
    extends BaseViewModel<LoginSignUpNavigationSet> with Store {
  _LoginSignUpViewModel();

  @override
  @observable
  LoginSignUpNavigationSet? flow = LoginSignUpNavigationSet.home;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  String? title = "";

  @override
  @observable
  StatusModel? status;

  final signInUseCase = Modular.get<SignUpUseCase<StatusModel>>();
  final publicKeyUseCase = Modular.get<GetPublicKeyUseCase<PublicKeyModel>>();

  void getPublicKey() async {
    state = ViewState.loading;
    await publicKeyUseCase.invoke(
        success: (response) {
          Session.instance
              .setKeyChain(CryptoService.instance.generateAESKeys());
          Session.instance.setRSAKey(response);
          state = ViewState.ready;
        },
        error: onError);
  }

  signIn(String name, String surname, String mail, String password,
      String country) async {
    state = ViewState.loading;
    await signInUseCase
        .params(
            name: name,
            surname: surname,
            email: mail,
            password: password,
            country: country)
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
              onRoute(LoginSignUpNavigationSet.status);
            },
            error: onError);
  }
}
