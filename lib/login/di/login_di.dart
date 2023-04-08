import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/navigation/routes.dart';
import 'package:e_racing_app/event/di/event_di.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:e_racing_app/home/di/home_di.dart';
import 'package:e_racing_app/login/data/model/login_response.dart';
import 'package:e_racing_app/login/domain/model/public_key_model.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:e_racing_app/login/domain/usecase/forgot_password_usecase.dart';
import 'package:e_racing_app/login/domain/usecase/get_public_key_usecase.dart';
import 'package:e_racing_app/login/domain/usecase/get_user_usecase.dart';
import 'package:e_racing_app/login/domain/usecase/login_2fa_usecase.dart';
import 'package:e_racing_app/login/domain/usecase/login_usecase.dart';
import 'package:e_racing_app/login/domain/usecase/reset_password_usecase.dart';
import 'package:e_racing_app/login/domain/usecase/save_user_usecase.dart';
import 'package:e_racing_app/login/domain/usecase/sign_in_usecase.dart';
import 'package:e_racing_app/login/domain/usecase/toogle_2fa_usecase.dart';
import 'package:e_racing_app/login/presentation/login_view_model.dart';
import 'package:e_racing_app/login/presentation/ui/login_screen.dart';
import 'package:e_racing_app/profile/di/profile_di.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../event/create/di/event_create_di.dart';
import '../../league/create/di/league_create_di.dart';
import '../../league/home/di/league_di.dart';
import '../../league/home/presentation/ui/navigation/league_flow.dart';
import '../../notification/di/notification_di.dart';

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
        ModuleRoute(Routes.leagues, module: LeagueModule()),
        ModuleRoute(Routes.leagueCreation, module: LeagueCreateModule()),
        ModuleRoute(Routes.league,
            module: LeagueModule(flow: LeagueFlow.detail)),
        ModuleRoute(Routes.event,
            module: EventModule(flow: EventFlow.eventDetail)),
        ModuleRoute(Routes.eventFilter,
            module: EventModule(flow: EventFlow.listFiltered)),
        ModuleRoute(Routes.eventCreate, module: EventCreateModule()),
        ModuleRoute(Routes.events, module: EventModule()),
        ModuleRoute(Routes.profile, module: ProfileModule()),
        ModuleRoute(Routes.notifications, module: NotificationModule()),
      ];
}
