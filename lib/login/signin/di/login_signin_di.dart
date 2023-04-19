import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/login_signin_screen.dart';
import '../presentation/navigation/login_signin_navigation.dart';

class LoginSigninModule extends Module {
  final LoginSigninNavigationSet flow;

  LoginSigninModule({this.flow = LoginSigninNavigationSet.home});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => GetTagUseCase()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginSigninScreen()),
      ];
}
