import 'package:e_racing_app/core/navigation/routes.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:e_racing_app/event/list/di/event_list_di.dart';
import 'package:e_racing_app/home/di/home_di.dart';
import 'package:e_racing_app/league/detail/di/league_detail_di.dart';
import 'package:e_racing_app/profile/di/profile_di.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../event/core/di/event_di.dart';
import '../../event/core/presentation/ui/event_flow.dart';
import '../../event/create/di/event_create_di.dart';
import '../../event/detail/di/event_detail_di.dart';
import '../../event/manage/di/event_manage_di.dart';
import '../../event/update/di/event_update_di.dart';
import '../../league/LeagueRouter.dart';
import '../../league/create/di/league_create_di.dart';
import '../../league/list/di/league_list_di.dart';
import '../../league/member/di/league_member_di.dart';
import '../../login/login_router.dart';
import '../../login/onboard/di/login_onboard_di.dart';
import '../../login/recovery/di/login_password_recovery_di.dart';
import '../../login/signin/di/login_sign_in_di.dart';
import '../../login/signup/di/login_sign_up_di.dart';
import '../../push/di/push_notification_di.dart';
import '../domain/get_tutorial_exhibition_usecase.dart';
import '../presentation/app_screen.dart';
import '../presentation/app_view_model.dart';

class AppMainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => AppViewModel()),
        Bind.factory((i) => GetTutorialExhibitionUserUseCase<bool>()),
      ];

  var primaryTransition = TransitionType.fadeIn;
  var secondaryTransition = TransitionType.rightToLeftWithFade;

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AppScreen()),

        //Login
        ModuleRoute(
          LoginRouter.onboard,
          module: LoginOnboardModule(),
          transition: primaryTransition,
        ),
        ModuleRoute(
          LoginRouter.signUp,
          module: LoginSignUpModule(),
          transition: secondaryTransition,
        ),
        ModuleRoute(
          LoginRouter.signIn,
          module: LoginSignInModule(),
          transition: secondaryTransition,
        ),
        ModuleRoute(LoginRouter.recovery,
            module: LoginPasswordRecoveryModule()),

        ModuleRoute(Routes.home, module: HomeModule()),

        //League
        ModuleRoute(
          LeagueRouter.list,
          module: LeagueListModule(),
          transition: primaryTransition,
        ),
        ModuleRoute(
          LeagueRouter.create,
          module: LeagueCreateModule(),
          transition: secondaryTransition,
        ),
        ModuleRoute(
          LeagueRouter.detail,
          module: LeagueDetailModule(),
          transition: secondaryTransition,
        ),
        ModuleRoute(
          LeagueRouter.members,
          module: LeagueMemberModule(),
          transition: secondaryTransition,
        ),

        //Event
        ModuleRoute(
          EventRouter.list,
          module: EventListModule(),
          transition: primaryTransition,
        ),
        ModuleRoute(
          EventRouter.detail,
          module: EventDetailModule(),
          transition: secondaryTransition,
        ),
        ModuleRoute(
          EventRouter.create,
          module: EventCreateModule(),
          transition: secondaryTransition,
        ),
        ModuleRoute(
          EventRouter.manage,
          module: EventManageModule(),
          transition: secondaryTransition,
        ),
        ModuleRoute(
          EventRouter.update,
          module: EventUpdateModule(),
          transition: secondaryTransition,
        ),

        //Profile
        ModuleRoute(
          Routes.profile,
          module: ProfileModule(),
          transition: primaryTransition,
        ),

        ModuleRoute(Routes.event,
            module: EventModule(flow: EventFlow.eventDetail)),
        ModuleRoute(Routes.eventFilter,
            module: EventModule(flow: EventFlow.listFiltered)),
        ModuleRoute(Routes.eventCreate, module: EventCreateModule()),
        ModuleRoute(Routes.events, module: EventModule()),

        ModuleRoute(Routes.notifications, module: NotificationModule()),
      ];
}
