import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/user_model.dart';
import 'navigation/login_onboarding_navigation.dart';

part 'login_onboarding_view_model.g.dart';

class LoginOnboardingViewModel = _LoginOnboardingViewModel
    with _$LoginOnboardingViewModel;

abstract class _LoginOnboardingViewModel with Store {
  _LoginOnboardingViewModel();

  @observable
  LoginOnboardingNavigationSet flow = LoginOnboardingNavigationSet.home;

  @observable
  ViewState state = ViewState.ready;

  @observable
  UserModel? user;

  @observable
  StatusModel? status;

  setUrl(String? value) {
    Session.instance.setURL(value ?? '');
  }
}
