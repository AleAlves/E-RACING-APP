import 'package:e_racing_app/event/detail/presentation/router/event_detail_router.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/media_model.dart';
import '../../../core/model/status_model.dart';
import '../../../media/get_media.usecase.dart';
import '../../core/data/event_home_model.dart';
import '../../core/data/event_standings_model.dart';
import '../../core/data/event_teams_standings_model.dart';
import '../../core/data/race_standings_model.dart';
import '../domain/create_team_usecase.dart';
import '../domain/delete_team_usecase.dart';
import '../domain/get_event_usecase.dart';
import '../domain/get_standing_usecase.dart';
import '../domain/join_team_usecase.dart';
import '../domain/leave_team_usecase.dart';
import '../domain/race_standing_usecase.dart';
import '../domain/subscribe_event_usecase.dart';
import '../domain/teams_standing_usecase.dart';
import '../domain/unsubscribe_event_usecase.dart';
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
        Bind.factory((i) => GetStandingUseCase<EventStandingsModel>()),
        Bind.factory((i) => GetEventUseCase<EventHomeModel>()),
        Bind.factory((i) => SubscribeEventUseCase<StatusModel>()),
        Bind.factory((i) => UnsubscribeEventUseCase<StatusModel>()),
        Bind.factory((i) => GetMediaUseCase<MediaModel>()),
        Bind.factory((i) => TeamsStandingUseCase<EventTeamsStandingsModel>()),
        Bind.factory((i) => RaceStandingsUseCase<RaceStandingsModel>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const EventDetailScreen()),
      ];
}
