import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/usecase/forgot_password_usecase.dart';
import '../../legacy/domain/usecase/reset_password_usecase.dart';
import '../domain/retry_mail_validation_usecase.dart';
import 'navigation/login_password_recovery_navigation.dart';

part 'login_password_recovery_view_model.g.dart';

class LoginPasswordRecoveryViewModel = _LoginPasswordRecoveryViewModel
    with _$LoginPasswordRecoveryViewModel;

abstract class _LoginPasswordRecoveryViewModel
    extends BaseViewModel<LoginPasswordRecoveryNavigationSet> with Store {
  _LoginPasswordRecoveryViewModel();

  @override
  @observable
  LoginPasswordRecoveryNavigationSet? flow =
      LoginPasswordRecoveryNavigationSet.recover;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "";

  @observable
  String email = '';

  final forgotPassword = Modular.get<ForgotPasswordUseCase<StatusModel>>();
  final resetPassword = Modular.get<ResetPasswordUseCase<StatusModel>>();
  final retryMail = Modular.get<RetryMailValidationUseCase<StatusModel>>();

  retryMailValidation(String email) async {
    this.email = email;
    state = ViewState.loading;
    await retryMail.params(email: email).invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onNavigate(LoginPasswordRecoveryNavigationSet.status);
        },
        error: onError);
  }

  forgot(String email) async {
    this.email = email;
    state = ViewState.loading;
    await forgotPassword.params(email: email).invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onNavigate(LoginPasswordRecoveryNavigationSet.status);
        },
        error: onError);
  }

  reset(String password, String code) async {
    state = ViewState.loading;
    await resetPassword
        .params(code: code, email: email, password: password)
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
              onNavigate(LoginPasswordRecoveryNavigationSet.status);
            },
            error: onError);
  }
}
