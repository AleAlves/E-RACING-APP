import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/user_model.dart';
import 'navigation/login_forgot_password_navigation.dart';

part 'login_forgot_password_view_model.g.dart';

class LoginForgotPasswordViewModel = _LoginForgotPasswordViewModel
    with _$LoginForgotPasswordViewModel;

abstract class _LoginForgotPasswordViewModel with Store {
  _LoginForgotPasswordViewModel();

  @observable
  LoginForgotPasswordNavigationSet flow = LoginForgotPasswordNavigationSet.home;

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
