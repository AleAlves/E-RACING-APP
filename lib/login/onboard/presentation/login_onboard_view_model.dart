import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/user_model.dart';
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

  @observable
  UserModel? user;

  setUrl(String? value) {
    Session.instance.setURL(value ?? '');
  }
}
