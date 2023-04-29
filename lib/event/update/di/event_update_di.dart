import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/media_model.dart';
import '../../../core/model/status_model.dart';
import '../../../shared/media/get_media.usecase.dart';
import '../../detail/domain/create_team_usecase.dart';
import '../../detail/domain/delete_team_usecase.dart';
import '../../detail/domain/join_team_usecase.dart';
import '../../detail/domain/leave_team_usecase.dart';
import '../../detail/domain/remove_subcription_usecase.dart';
import '../../manage/domain/update_event_usecase.dart';
import '../presentation/event_update_screen.dart';
import '../presentation/event_update_view_model.dart';
import '../presentation/router/event_update_router.dart';

class EventUpdateModule extends Module {
  final EventUpdateRouter router;

  EventUpdateModule({this.router = EventUpdateRouter.main});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => EventUpdateViewModel()),
        Bind.factory((i) => CreateTeamUseCase<StatusModel>()),
        Bind.factory((i) => LeaveTeamUseCase<StatusModel>()),
        Bind.factory((i) => JoinTeamUseCase<StatusModel>()),
        Bind.factory((i) => DeleteTeamUseCase<StatusModel>()),
        Bind.factory((i) => RemoveRegisterUseCase<StatusModel>()),
        Bind.factory((i) => GetMediaUseCase<MediaModel>()),
        Bind.factory((i) => UpdateEventUseCase<StatusModel>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const EventUpdateScreen()),
      ];
}
