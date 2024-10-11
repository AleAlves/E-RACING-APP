import 'package:e_racing_app/event/detail/presentation/router/event_detail_router.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/media_model.dart';
import '../../../core/model/status_model.dart';
import '../../../shared/media/get_media.usecase.dart';
import '../../core/data/event_home_model.dart';
import '../../core/data/event_standings_model.dart';
import '../../core/data/event_teams_standings_model.dart';
import '../domain/create_team_usecase.dart';
import '../domain/delete_team_usecase.dart';
import '../domain/get_event_usecase.dart';
import '../domain/get_standing_usecase.dart';
import '../domain/join_team_usecase.dart';
import '../domain/leave_team_usecase.dart';
import '../domain/subscribe_event_usecase.dart';
import '../domain/teams_standing_usecase.dart';
import '../domain/unsubscribe_event_usecase.dart';
import '../presentation/event_detail_screen.dart';
import '../presentation/event_detail_view_model.dart';

class EventDetailModule extends Module {
  final EventDetailRouter router;

  EventDetailModule({this.router = EventDetailRouter.main});

  @override
  void binds(i) {
    i.add<EventDetailViewModel>(EventDetailViewModel.new);
    i.add<CreateTeamUseCase<StatusModel>>(CreateTeamUseCase<StatusModel>.new);
    i.add<LeaveTeamUseCase<StatusModel>>(LeaveTeamUseCase<StatusModel>.new);
    i.add<JoinTeamUseCase<StatusModel>>(JoinTeamUseCase<StatusModel>.new);
    i.add<DeleteTeamUseCase<StatusModel>>(DeleteTeamUseCase<StatusModel>.new);
    i.add<GetStandingUseCase<EventStandingsModel>>(GetStandingUseCase<StatusModel>.new);
    i.add<GetEventUseCase<EventHomeModel>>(GetEventUseCase<EventHomeModel>.new);
    i.add<SubscribeEventUseCase<StatusModel>>(SubscribeEventUseCase<StatusModel>.new);
    i.add<UnsubscribeEventUseCase<StatusModel>>(UnsubscribeEventUseCase<StatusModel>.new);
    i.add<GetMediaUseCase<MediaModel>>(GetMediaUseCase<MediaModel>.new);
    i.add<TeamsStandingUseCase<EventTeamsStandingsModel>>(TeamsStandingUseCase<EventTeamsStandingsModel>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => EventDetailScreen());
  }
}
