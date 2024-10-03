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
    i.add<CreateTeamUseCase<StatusModel>>(CreateTeamUseCase.new);
    i.add<LeaveTeamUseCase<StatusModel>>(LeaveTeamUseCase.new);
    i.add<JoinTeamUseCase<StatusModel>>(JoinTeamUseCase.new);
    i.add<DeleteTeamUseCase<StatusModel>>(DeleteTeamUseCase.new);
    i.add<GetStandingUseCase<EventStandingsModel>>(GetStandingUseCase.new);
    i.add<GetEventUseCase<EventHomeModel>>(GetEventUseCase.new);
    i.add<SubscribeEventUseCase<StatusModel>>(SubscribeEventUseCase.new);
    i.add<UnsubscribeEventUseCase<StatusModel>>(UnsubscribeEventUseCase.new);
    i.add<GetMediaUseCase<MediaModel>>(GetMediaUseCase.new);
    i.add<TeamsStandingUseCase<EventTeamsStandingsModel>>(TeamsStandingUseCase.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => EventDetailScreen());
  }
}
