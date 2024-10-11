import 'package:flutter_modular/flutter_modular.dart';

import '../domain/set_tutorial_exhibition_usecase.dart';
import '../presentation/login_onboard_screen.dart';
import '../presentation/login_onboard_view_model.dart';

class LoginOnboardModule extends Module {

  @override
  void binds(i){
    i.add<LoginOnboardViewModel>(LoginOnboardViewModel.new);
    i.add<SetTutorialExhibitionUserUseCase<void>>(SetTutorialExhibitionUserUseCase<void>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginOnboardScreen());
  }
}
