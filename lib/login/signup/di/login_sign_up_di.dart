import 'package:e_racing_app/login/signup/presentation/login_sign_up_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/status_model.dart';
import '../../legacy/domain/model/public_key_model.dart';
import '../../legacy/domain/usecase/get_public_key_usecase.dart';
import '../../legacy/domain/usecase/sign_up_usecase.dart';
import '../presentation/login_sign_up_screen.dart';
import '../presentation/navigation/login_sign_up_navigation.dart';

class LoginSignUpModule extends Module {
  final LoginSignUpNavigationSet flow;

  LoginSignUpModule({this.flow = LoginSignUpNavigationSet.home});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginSignUpViewModel()),
        Bind.factory((i) => SignUpUseCase<StatusModel>()),
        Bind.factory((i) => GetPublicKeyUseCase<PublicKeyModel>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginSignUpScreen()),
      ];
}
