import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/ui/view_state.dart';
import '../domain/set_tutorial_exhibition_usecase.dart';
import 'navigation/login_onboard_navigation.dart';

part 'login_onboard_view_model.g.dart';

class LoginOnboardViewModel = _LoginOnboardViewModel
    with _$LoginOnboardViewModel;

abstract class _LoginOnboardViewModel
    extends BaseViewModel<LoginOnboardNavigationSet> with Store {
  _LoginOnboardViewModel();

  @override
  @observable
  LoginOnboardNavigationSet? flow = LoginOnboardNavigationSet.home;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "";

  final _setExhibition = Modular.get<SetTutorialExhibitionUserUseCase<void>>();

  saveTutorialExhibition(String route) async {
    await _setExhibition.invoke(
        success: (data) {
          Modular.to.pushNamed(route);
        },
        failure: onError);
  }
}
