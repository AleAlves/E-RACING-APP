import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/user_model.dart';
import 'navigation/login_code_generate_navigation.dart';

part 'login_code_generate_view_model.g.dart';

class LoginCodeGenerateViewModel = _LoginCodeGenerateViewModel
    with _$LoginCodeGenerateViewModel;

abstract class _LoginCodeGenerateViewModel with Store {
  _LoginCodeGenerateViewModel();

  @observable
  LoginGenerateCodeNavigationSet flow = LoginGenerateCodeNavigationSet.home;

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
