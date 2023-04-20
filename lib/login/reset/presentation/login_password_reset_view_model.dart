import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/ui/view_state.dart';
import '../../legacy/domain/model/user_model.dart';
import '../../legacy/domain/usecase/reset_password_usecase.dart';
import 'navigation/login_password_reset_navigation.dart';

part 'login_password_reset_view_model.g.dart';

class LoginPasswordResetViewModel = _LoginPasswordResetViewModel
    with _$LoginPasswordResetViewModel;

abstract class _LoginPasswordResetViewModel
    extends BaseViewModel<LoginPasswordResetNavigationSet> with Store {
  _LoginPasswordResetViewModel();

  @override
  @observable
  LoginPasswordResetNavigationSet? flow = LoginPasswordResetNavigationSet.home;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  StatusModel? status;

  @observable
  UserModel? user;

  final resetPasswordUseCase = Modular.get<ResetPasswordUseCase<StatusModel>>();

  void reset(String mail, String password, String code) async {
    state = ViewState.loading;
    await resetPasswordUseCase
        .params(code: code, email: code, password: password)
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
              onNavigate(LoginPasswordResetNavigationSet.status);
            },
            error: onError);
  }
}
