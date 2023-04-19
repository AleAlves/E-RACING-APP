import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/user_model.dart';
import 'navigation/login_password_reset_navigation.dart';

part 'login_password_reset_view_model.g.dart';

class LoginPasswordResetViewModel = _LoginPasswordResetViewModel
    with _$LoginPasswordResetViewModel;

abstract class _LoginPasswordResetViewModel with Store {
  _LoginPasswordResetViewModel();

  @observable
  LoginPasswordResetNavigationSet flow = LoginPasswordResetNavigationSet.home;

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
