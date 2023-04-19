import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/user_model.dart';
import 'navigation/login_signin_navigation.dart';

part 'login_signin_view_model.g.dart';

class LoginSigninViewModel = _LoginSigninViewModel with _$LoginSigninViewModel;

abstract class _LoginSigninViewModel with Store {
  _LoginSigninViewModel();

  @observable
  LoginSigninNavigationSet flow = LoginSigninNavigationSet.home;

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
