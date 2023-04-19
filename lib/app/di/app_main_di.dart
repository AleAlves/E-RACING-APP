import 'package:e_racing_app/core/navigation/routes.dart';
import 'package:e_racing_app/event/di/event_di.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:e_racing_app/home/di/home_di.dart';
import 'package:e_racing_app/profile/di/profile_di.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../event/create/di/event_create_di.dart';
import '../../league/create/di/league_create_di.dart';
import '../../league/home/di/league_di.dart';
import '../../league/home/presentation/ui/navigation/league_flow.dart';
import '../../login/onboarding/di/login_onboarding_di.dart';
import '../../notification/di/notification_di.dart';
import '../presentation/app_screen.dart';
import '../presentation/app_view_model.dart';

class AppMainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => AppViewModel()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AppScreen()),

        //Login
        ModuleRoute(Routes.loginOnboarding, module: LoginOnboardingModule()),

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
