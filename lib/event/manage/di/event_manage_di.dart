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
  void binds(i) {
    i.add<EventManageViewModel>(EventManageViewModel.new);
    i.add<CreateTeamUseCase<StatusModel>>(CreateTeamUseCase<StatusModel>.new);
    i.add<LeaveTeamUseCase<StatusModel>>(LeaveTeamUseCase<StatusModel>.new);
    i.add<JoinTeamUseCase<StatusModel>>(JoinTeamUseCase<StatusModel>.new);
    i.add<DeleteTeamUseCase<StatusModel>>(DeleteTeamUseCase<StatusModel>.new);
    i.add<RemoveRegisterUseCase<StatusModel>>(RemoveRegisterUseCase<StatusModel>.new);
    i.add<SetSummaryUseCase<StatusModel>>(SetSummaryUseCase<StatusModel>.new);
    i.add<ToogleSubscriptionsUseCase<StatusModel>>(ToogleSubscriptionsUseCase<StatusModel>.new);
    i.add<ToogleMembersOnlyUseCase<StatusModel>>(ToogleMembersOnlyUseCase<StatusModel>.new);
    i.add<StartEventUseCase<StatusModel>>(StartEventUseCase<StatusModel>.new);
    i.add<FinishEventUseCase<StatusModel>>(FinishEventUseCase<StatusModel>.new);
    i.add<FinishRaceUseCase<StatusModel>>(FinishRaceUseCase<StatusModel>.new);
    i.add<CancelRaceUseCase<StatusModel>>(CancelRaceUseCase<StatusModel>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const EventManageScreen());
  }
}
