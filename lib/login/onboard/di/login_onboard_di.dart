import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/login_onboard_screen.dart';
import '../presentation/login_onboard_view_model.dart';

class LoginOnboardModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginOnboardViewModel()),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => const LoginOnboardScreen())];
}
