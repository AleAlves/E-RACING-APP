import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/login_password_reset_screen.dart';
import '../presentation/navigation/login_password_reset_navigation.dart';

class LoginPasswordResetModule extends Module {
  final LoginPasswordResetNavigationSet flow;

  LoginPasswordResetModule({this.flow = LoginPasswordResetNavigationSet.home});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => GetTagUseCase()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const LoginPasswordResetScreen()),
      ];
}
