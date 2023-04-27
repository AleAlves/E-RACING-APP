import 'package:e_racing_app/event/detail/presentation/router/event_detail_router.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/status_model.dart';
import '../../core/domain/leave_team_usecase.dart';
import '../domain/create_team_usecase.dart';
import '../domain/delete_team_usecase.dart';
import '../domain/join_team_usecase.dart';
import '../presentation/event_detail_screen.dart';
import '../presentation/event_detail_view_model.dart';

class EventDetailModule extends Module {
  final EventDetailRouter router;

  EventDetailModule({this.router = EventDetailRouter.main});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => EventDetailViewModel()),
        Bind.factory((i) => CreateTeamUseCase<StatusModel>()),
        Bind.factory((i) => LeaveTeamUseCase<StatusModel>()),
        Bind.factory((i) => JoinTeamUseCase<StatusModel>()),
        Bind.factory((i) => DeleteTeamUseCase<StatusModel>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const EventDetailScreen()),
      ];
}
