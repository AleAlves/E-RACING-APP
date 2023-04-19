import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/user_model.dart';
import 'navigation/login_signup_navigation.dart';

part 'login_signup_view_model.g.dart';

class LoginSignupViewModel = _LoginSignupViewModel with _$LoginSignupViewModel;

abstract class _LoginSignupViewModel with Store {
  _LoginSignupViewModel();

  @observable
  LoginSignupNavigationSet flow = LoginSignupNavigationSet.home;

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
