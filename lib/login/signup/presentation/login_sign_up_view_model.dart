import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/model/tag_model.dart';
import '../../../core/tools/crypto/crypto_service.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../../legacy/domain/model/public_key_model.dart';
import '../../legacy/domain/usecase/get_public_key_usecase.dart';
import '../domain/sign_up_usecase.dart';
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

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @override
  @observable
  String? title = "Sign Up";

  @override
  @observable
  StatusModel? status;

  final _getTagUseCase = Modular.get<GetTagUseCase>();
  final _signUpUseCase = Modular.get<SignUpUseCase<StatusModel>>();
  final _publicKeyUseCase = Modular.get<GetPublicKeyUseCase<PublicKeyModel>>();

  void getPublicKey() async {
    state = ViewState.loading;
    await _publicKeyUseCase.invoke(
        success: (response) {
          Session.instance
              .setKeyChain(CryptoService.instance.generateAESKeys());
          Session.instance.setRSAKey(response);
          fetchTags();
        },
        failure: onError);
  }

  void fetchTags() async {
    await _getTagUseCase.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          state = ViewState.ready;
        },
        failure: onError);
  }

  signIn(String firstName, String surName, String mail, String password,
      String country, List<String> tags) async {
    state = ViewState.loading;
    await _signUpUseCase
        .params(
            firstName: firstName,
            surName: surName,
            email: mail,
            password: password,
            country: country,
            tags: tags)
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
              onRoute(LoginSignUpNavigationSet.status);
            },
            failure: onError);
  }
}
