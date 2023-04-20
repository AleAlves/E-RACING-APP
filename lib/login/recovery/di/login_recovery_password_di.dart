import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/status_model.dart';
import '../../legacy/domain/usecase/forgot_password_usecase.dart';
import '../presentation/login_recovery_password_screen.dart';
import '../presentation/login_recovery_password_view_model.dart';
import '../presentation/navigation/login_recovery_password_navigation.dart';

class LoginRecoveryPasswordModule extends Module {
  final LoginRecoveryPasswordNavigationSet flow;

  LoginRecoveryPasswordModule(
      {this.flow = LoginRecoveryPasswordNavigationSet.home});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginRecoveryPasswordViewModel()),
        Bind.factory((i) => ForgotPasswordUseCase<StatusModel>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const LoginRecoveryPasswordScreen()),
      ];
}
