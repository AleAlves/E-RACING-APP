import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../generate/presentation/navigation/login_code_generate_navigation.dart';
import '../presentation/login_forgot_password_screen.dart';

class LoginForgotPasswordModule extends Module {
  final LoginGenerateCodeNavigationSet flow;

  LoginForgotPasswordModule({this.flow = LoginGenerateCodeNavigationSet.home});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => GetTagUseCase()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const LoginForgotPasswordScreen()),
      ];
}
