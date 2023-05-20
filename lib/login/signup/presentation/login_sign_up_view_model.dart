import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/login/signup/presentation/router/login_sign_up_navigation.dart';
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

part 'login_sign_up_view_model.g.dart';

class LoginSignUpViewModel = _LoginSignUpViewModel with _$LoginSignUpViewModel;

abstract class _LoginSignUpViewModel extends BaseViewModel<LoginSignUpRouterSet>
    with Store {
  _LoginSignUpViewModel();

  @override
  @observable
  LoginSignUpRouterSet? flow = LoginSignUpRouterSet.terms;

  @override
  @observable
  ViewState state = ViewState.ready;

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<String?>? userTags = ObservableList();

  @override
  @observable
  String? title = "Sign Up";

  @override
  @observable
  StatusModel? status;

  @observable
  int maxSteps = 7;

  @observable
  int currentStep = 1;

  @observable
  String? name = "";

  @observable
  String? surname = "";

  @observable
  String? email = "";

  @observable
  String? password = "";

  @observable
  String? nationality = "";

  final _getTagUseCase = Modular.get<GetTagUseCase>();
  final _signUpUseCase = Modular.get<SignUpUseCase<StatusModel>>();
  final _publicKeyUseCase = Modular.get<GetPublicKeyUseCase<PublicKeyModel>>();

  _increaseStep() {
    currentStep++;
  }

  decreaseStep(LoginSignUpRouterSet route) {
    onRoute(route);
    currentStep--;
  }

  void setAgreement(bool termsAgreement) {
    onRoute(LoginSignUpRouterSet.name);
    _increaseStep();
  }

  void setNames(String name, String surname) {
    this.name = name;
    this.surname = surname;
    onRoute(LoginSignUpRouterSet.email);
    _increaseStep();
  }

  void setEmail(String email) {
    this.email = email;
    onRoute(LoginSignUpRouterSet.nationality);
    _increaseStep();
  }

  void setNationality(String? nationality) {
    this.nationality = nationality;
    onRoute(LoginSignUpRouterSet.tags);
    _increaseStep();
  }

  void setTags() {
    onRoute(LoginSignUpRouterSet.password);
    _increaseStep();
  }

  void setPassword(String? password) {
    this.password = password;
    onRoute(LoginSignUpRouterSet.review);
    _increaseStep();
  }

  void getPublicKey() async {
    state = ViewState.loading;
    await _publicKeyUseCase.invoke(
        success: (response) {
          Session.instance
              .setKeyChain(CryptoService.instance.generateAESKeys());
          Session.instance.setRSAKey(response);
          state = ViewState.ready;
        },
        failure: onError);
  }

  void getTags() async {
    if (tags?.isEmpty == true) {
      state = ViewState.loading;
      await _getTagUseCase.invoke(
          success: (data) {
            tags = ObservableList.of(data);
            state = ViewState.ready;
          },
          failure: onError);
    }
  }

  signIn() async {
    state = ViewState.loading;
    await _signUpUseCase
        .params(
            firstName: name,
            surName: surname,
            email: email,
            password: password,
            country: nationality,
            tags: userTags)
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
              onRoute(LoginSignUpRouterSet.status);
            },
            failure: onError);
  }
}
