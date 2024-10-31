import 'package:e_racing_app/event/event_router.dart';
import 'package:e_racing_app/event/list/di/event_list_di.dart';
import 'package:e_racing_app/home/HomeRouter.dart';
import 'package:e_racing_app/home/di/home_di.dart';
import 'package:e_racing_app/league/detail/di/league_detail_di.dart';
import 'package:e_racing_app/profile/ProfileRouter.dart';
import 'package:e_racing_app/profile/di/profile_di.dart';
import 'package:e_racing_app/push/PushRouter.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../event/create/di/event_create_di.dart';
import '../../event/detail/di/event_detail_di.dart';
import '../../event/list/presentation/router/event_list_router.dart';
import '../../event/manage/main/di/event_manage_di.dart';
import '../../event/update/di/event_update_di.dart';
import '../../league/LeagueRouter.dart';
import '../../league/create/di/league_create_di.dart';
import '../../league/list/di/league_list_di.dart';
import '../../league/list/presentation/router/league_list_router.dart';
import '../../league/member/di/league_member_di.dart';
import '../../league/trophies/di/league_trophies_di.dart';
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
  void binds(i) {
    i.add<AppViewModel>(AppViewModel.new);
    i.add<GetTutorialExhibitionUserUseCase<bool>>(GetTutorialExhibitionUserUseCase<bool>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => AppScreen());
    r.module(LoginRouter.onboard, module: LoginOnboardModule());
    r.module(LoginRouter.signUp, module: LoginSignUpModule());
    r.module(LoginRouter.signIn, module: LoginSignInModule());
    r.module(LoginRouter.recovery, module: LoginPasswordRecoveryModule());
    r.module(HomeRouter.main, module: HomeModule());
    r.module(LeagueRouter.list, module: LeagueListModule());
    r.module(LeagueRouter.owned, module: LeagueListModule(router: LeagueListRouterSet.owned));
    r.module(LeagueRouter.create, module: LeagueCreateModule());
    r.module(LeagueRouter.detail, module: LeagueDetailModule());
    r.module(LeagueRouter.members, module: LeagueMemberModule());
    r.module(LeagueRouter.trophies, module: LeagueTrophiesModule());
    r.module(EventRouter.list, module: EventListModule());
    r.module(EventRouter.search, module: EventListModule(router: EventListRouter.search));
    r.module(EventRouter.detail, module: EventDetailModule());
    r.module(EventRouter.create, module: EventCreateModule());
    r.module(EventRouter.manage, module: EventManageModule());
    r.module(EventRouter.update, module: EventUpdateModule());
    r.module(ProfileRouter.main, module: ProfileModule());
    r.module(PushRouter.main, module: NotificationModule());
  }

  var primaryTransition = TransitionType.fadeIn;
  var secondaryTransition = TransitionType.rightToLeftWithFade;

}
