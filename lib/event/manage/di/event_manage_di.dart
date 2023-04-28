import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/status_model.dart';
import '../../detail/domain/create_team_usecase.dart';
import '../../detail/domain/delete_team_usecase.dart';
import '../../detail/domain/join_team_usecase.dart';
import '../../detail/domain/leave_team_usecase.dart';
import '../../detail/domain/remove_subcription_usecase.dart';
import '../domain/cancel_race_use_case.dart';
import '../domain/finish_event_usecase.dart';
import '../domain/finish_race_use_case.dart';
import '../domain/set_result_event_usecase.dart';
import '../domain/start_event_usecase.dart';
import '../domain/toogle_members_only_usecase.dart';
import '../domain/toogle_subscriptions_usecase.dart';
import '../presentation/event_manage_screen.dart';
import '../presentation/event_manage_view_model.dart';
import '../presentation/router/event_manage_router.dart';

class EventManageModule extends Module {
  final EventManageRouter router;

  EventManageModule({this.router = EventManageRouter.main});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => EventManageViewModel()),
        Bind.factory((i) => CreateTeamUseCase<StatusModel>()),
        Bind.factory((i) => LeaveTeamUseCase<StatusModel>()),
        Bind.factory((i) => JoinTeamUseCase<StatusModel>()),
        Bind.factory((i) => DeleteTeamUseCase<StatusModel>()),
        Bind.factory((i) => RemoveRegisterUseCase<StatusModel>()),
        Bind.factory((i) => SetSummaryUseCase<StatusModel>()),
        Bind.factory((i) => ToogleSubscriptionsUseCase<StatusModel>()),
        Bind.factory((i) => ToogleMembersOnlyUseCase<StatusModel>()),
        Bind.factory((i) => StartEventUseCase<StatusModel>()),
        Bind.factory((i) => FinishEventUseCase<StatusModel>()),
        Bind.factory((i) => FinishRaceUseCase<StatusModel>()),
        Bind.factory((i) => CancelRaceUseCase<StatusModel>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const EventManageScreen()),
      ];
}
