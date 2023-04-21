import 'package:flutter_modular/flutter_modular.dart';

import '../domain/set_tutorial_exhibition_usecase.dart';
import '../presentation/login_onboard_screen.dart';
import '../presentation/login_onboard_view_model.dart';

class LoginOnboardModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginOnboardViewModel()),
        Bind.factory((i) => SetTutorialExhibitionUserUseCase<void>()),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => const LoginOnboardScreen())];
}
