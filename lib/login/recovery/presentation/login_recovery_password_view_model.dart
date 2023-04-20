import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/user_model.dart';
import '../../legacy/domain/usecase/forgot_password_usecase.dart';
import 'navigation/login_recovery_password_navigation.dart';

part 'login_recovery_password_view_model.g.dart';

class LoginRecoveryPasswordViewModel = _LoginRecoveryPasswordViewModel
    with _$LoginRecoveryPasswordViewModel;

abstract class _LoginRecoveryPasswordViewModel
    extends BaseViewModel<LoginRecoveryPasswordNavigationSet> with Store {
  _LoginRecoveryPasswordViewModel();

  @override
  @observable
  LoginRecoveryPasswordNavigationSet? flow =
      LoginRecoveryPasswordNavigationSet.home;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  StatusModel? status;

  @observable
  UserModel? user;

  final forgotUC = Modular.get<ForgotPasswordUseCase<StatusModel>>();

  void forgot(String mail) async {
    state = ViewState.loading;
    await forgotUC.params(email: mail).invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onNavigate(LoginRecoveryPasswordNavigationSet.status);
        },
        error: onError);
  }
}
