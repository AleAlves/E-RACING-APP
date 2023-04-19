import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/login_code_generate_screen.dart';
import '../presentation/navigation/login_code_generate_navigation.dart';

class LoginPasswordResetModule extends Module {
  final LoginGenerateCodeNavigationSet flow;

  LoginPasswordResetModule({this.flow = LoginGenerateCodeNavigationSet.home});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => GetTagUseCase()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const LoginCodeGenerateScreen()),
      ];
}
