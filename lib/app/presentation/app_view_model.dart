import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/model/status_model.dart';
import '../../core/tools/session.dart';
import '../../core/ui/view_state.dart';
import '../../login/legacy/domain/model/user_model.dart';
import '../../login/login_router.dart';
import 'navigation/app_navigation.dart';

part 'app_view_model.g.dart';

class AppViewModel = _LoginViewModel with _$AppViewModel;

abstract class _LoginViewModel with Store {
  _LoginViewModel();

  @observable
  AppNavigationSet flow = AppNavigationSet.appEnviroment;

  @observable
  ViewState state = ViewState.ready;

  @observable
  UserModel? user;

  @observable
  StatusModel? status;

  setUrl(String? value) {
    Session.instance.setURL(value ?? '');
    Modular.to.pushNamed(LoginRouter.onboard);
  }
}
