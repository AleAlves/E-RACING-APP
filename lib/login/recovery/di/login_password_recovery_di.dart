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
  List<Bind> get binds => [
        Bind.factory((i) => LoginPasswordRecoveryViewModel()),
        Bind.factory((i) => ResetPasswordUseCase<StatusModel>()),
        Bind.factory((i) => ForgotPasswordUseCase<StatusModel>()),
        Bind.factory((i) => RetryMailValidationUseCase<StatusModel>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const LoginPasswordRecoveryScreen()),
      ];
}
