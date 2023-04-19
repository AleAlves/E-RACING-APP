import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/login_signup_screen.dart';
import '../presentation/navigation/login_signup_navigation.dart';

class LoginSignupModule extends Module {
  final LoginSignupNavigationSet flow;

  LoginSignupModule({this.flow = LoginSignupNavigationSet.home});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => GetTagUseCase()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginSignupScreen()),
      ];
}
