import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/navigation/routes.dart';
import 'package:e_racing_app/home/di/home_di.dart';
import 'package:e_racing_app/login/legacy/data/model/login_response.dart';
import 'package:e_racing_app/login/legacy/domain/model/public_key_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:e_racing_app/login/legacy/domain/usecase/forgot_password_usecase.dart';
import 'package:e_racing_app/login/legacy/domain/usecase/get_public_key_usecase.dart';
import 'package:e_racing_app/login/legacy/domain/usecase/get_user_usecase.dart';
import 'package:e_racing_app/login/legacy/domain/usecase/login_2fa_usecase.dart';
import 'package:e_racing_app/login/legacy/domain/usecase/login_usecase.dart';
import 'package:e_racing_app/login/legacy/domain/usecase/reset_password_usecase.dart';
import 'package:e_racing_app/login/legacy/domain/usecase/save_user_usecase.dart';
import 'package:e_racing_app/login/legacy/domain/usecase/sign_in_usecase.dart';
import 'package:e_racing_app/login/legacy/domain/usecase/toogle_2fa_usecase.dart';
import 'package:e_racing_app/login/legacy/presentation/login_view_model.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/login_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginViewModel()),
        Bind.factory((i) => GetPublicKeyUseCase<PublicKeyModel>()),
        Bind.factory((i) => LoginUseCase<LoginResponse>()),
        Bind.factory((i) => Toogle2FAUseCase<Pair<StatusModel, String>>()),
        Bind.factory((i) => Login2FAUseCase<StatusModel>()),
        Bind.factory((i) => SignInUseCase<StatusModel>()),
        Bind.factory((i) => ForgotPasswordUseCase<StatusModel>()),
        Bind.factory((i) => ResetPasswordUseCase<StatusModel>()),
        Bind.factory((i) => GetUserUseCase<UserModel?>()),
        Bind.factory((i) => SaveUserUseCase()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginScreen()),
        ModuleRoute(Routes.home, module: HomeModule()),
      ];
}
