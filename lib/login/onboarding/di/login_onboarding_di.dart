import 'package:e_racing_app/core/navigation/routes.dart';
import 'package:e_racing_app/home/di/home_di.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/login_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/login_onboarding_view_model.dart';

class LoginOnboardingModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginOnboardingViewModel()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginScreen()),
        ModuleRoute(Routes.home, module: HomeModule()),
      ];
}
