import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/status_model.dart';
import '../../legacy/domain/usecase/forgot_password_usecase.dart';
import '../../legacy/domain/usecase/reset_password_usecase.dart';
import '../domain/retry_mail_validation_usecase.dart';
import '../presentation/login_password_recovery_screen.dart';
import '../presentation/login_password_recovery_view_model.dart';
import '../presentation/navigation/login_password_recovery_navigation.dart';

class LoginPasswordRecoveryModule extends Module {
  final LoginPasswordRecoveryNavigationSet flow;

  LoginPasswordRecoveryModule(
      {this.flow = LoginPasswordRecoveryNavigationSet.recover});

  @override
  void binds(i) {
    i.add<LoginPasswordRecoveryViewModel>(LoginPasswordRecoveryViewModel.new);
    i.add<ResetPasswordUseCase<StatusModel>>(ResetPasswordUseCase<StatusModel>.new);
    i.add<ForgotPasswordUseCase<StatusModel>>(ForgotPasswordUseCase<StatusModel>.new);
    i.add<RetryMailValidationUseCase<StatusModel>>(RetryMailValidationUseCase<StatusModel>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginPasswordRecoveryScreen());
  }
}
