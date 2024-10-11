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
import '../domain/update_race_usecase.dart';
import '../presentation/event_update_screen.dart';
import '../presentation/event_update_view_model.dart';
import '../presentation/router/event_update_router.dart';

class EventUpdateModule extends Module {
  final EventUpdateRouter router;

  EventUpdateModule({this.router = EventUpdateRouter.main});

  @override
  void binds(i) {
    i.add<EventUpdateViewModel>(EventUpdateViewModel.new);
    i.add<CreateTeamUseCase<StatusModel>>(CreateTeamUseCase<StatusModel>.new);
    i.add<LeaveTeamUseCase<StatusModel>>(LeaveTeamUseCase<StatusModel>.new);
    i.add<JoinTeamUseCase<StatusModel>>(JoinTeamUseCase<StatusModel>.new);
    i.add<DeleteTeamUseCase<StatusModel>>(DeleteTeamUseCase<StatusModel>.new);
    i.add<RemoveRegisterUseCase<StatusModel>>(RemoveRegisterUseCase<StatusModel>.new);
    i.add<GetMediaUseCase<MediaModel>>(GetMediaUseCase<StatusModel>.new);
    i.add<UpdateEventUseCase<StatusModel>>(UpdateEventUseCase<StatusModel>.new);
    i.add<UpdateRaceUseCase<StatusModel>>(UpdateRaceUseCase<StatusModel>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const EventUpdateScreen());
  }
}
