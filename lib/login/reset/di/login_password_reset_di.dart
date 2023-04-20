import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/status_model.dart';
import '../../legacy/domain/usecase/reset_password_usecase.dart';
import '../presentation/login_password_reset_screen.dart';
import '../presentation/login_password_reset_view_model.dart';
import '../presentation/navigation/login_password_reset_navigation.dart';

class LoginPasswordResetModule extends Module {
  final LoginPasswordResetNavigationSet flow;

  LoginPasswordResetModule({this.flow = LoginPasswordResetNavigationSet.home});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => ResetPasswordUseCase<StatusModel>()),
        Bind.factory((i) => LoginPasswordResetViewModel()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const LoginPasswordResetScreen()),
      ];
}
