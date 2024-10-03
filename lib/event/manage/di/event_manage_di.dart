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
    i.add<CreateTeamUseCase<StatusModel>>(CreateTeamUseCase.new);
    i.add<LeaveTeamUseCase<StatusModel>>(LeaveTeamUseCase.new);
    i.add<JoinTeamUseCase<StatusModel>>(JoinTeamUseCase.new);
    i.add<DeleteTeamUseCase<StatusModel>>(DeleteTeamUseCase.new);
    i.add<RemoveRegisterUseCase<StatusModel>>(RemoveRegisterUseCase.new);
    i.add<SetSummaryUseCase<StatusModel>>(SetSummaryUseCase.new);
    i.add<ToogleSubscriptionsUseCase<StatusModel>>(ToogleSubscriptionsUseCase.new);
    i.add<ToogleMembersOnlyUseCase<StatusModel>>(ToogleMembersOnlyUseCase.new);
    i.add<StartEventUseCase<StatusModel>>(StartEventUseCase.new);
    i.add<FinishEventUseCase<StatusModel>>(FinishEventUseCase.new);
    i.add<FinishRaceUseCase<StatusModel>>(FinishRaceUseCase.new);
    i.add<CancelRaceUseCase<StatusModel>>(CancelRaceUseCase.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const EventManageScreen());
  }
}
