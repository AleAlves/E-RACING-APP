import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/event/create/domain/create_event_usecase.dart';
import 'package:e_racing_app/event/detail/domain/delete_team_usecase.dart';
import 'package:e_racing_app/event/detail/domain/join_team_usecase.dart';
import 'package:e_racing_app/event/list/domain/fetch_events_use_case.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/media/get_media.usecase.dart';
import '../../../shared/social/get_social_media_usecase.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../../detail/domain/create_team_usecase.dart';
import '../../detail/domain/get_event_usecase.dart';
import '../../detail/domain/get_standing_usecase.dart';
import '../../detail/domain/leave_team_usecase.dart';
import '../../detail/domain/race_standing_usecase.dart';
import '../../detail/domain/remove_subcription_usecase.dart';
import '../../detail/domain/subscribe_event_usecase.dart';
import '../../detail/domain/teams_standing_usecase.dart';
import '../../detail/domain/unsubscribe_event_usecase.dart';
import '../../manage/domain/set_result_event_usecase.dart';
import '../../manage/domain/start_event_usecase.dart';
import '../../manage/domain/toogle_members_only_usecase.dart';
import '../../manage/domain/toogle_subscriptions_usecase.dart';
import '../../manage/domain/update_event_usecase.dart';
import '../data/event_home_model.dart';
import '../data/event_standings_model.dart';
import '../data/event_teams_standings_model.dart';
import '../data/race_standings_model.dart';
import '../domain/fetch_filtered_events_use_case.dart';
import '../domain/finish_event_usecase.dart';
import '../event_view_model.dart';
import '../presentation/ui/event_flow.dart';
import '../presentation/ui/event_screen.dart';

class EventModule extends Module {
  final EventFlow flow;

  EventModule({this.flow = EventFlow.list});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => EventViewModel()),
        Bind.factory((i) => GetMediaUseCase<MediaModel>()),
        Bind.factory((i) => FetchEventsUseCase<List<EventModel>>()),
        Bind.factory((i) => FetchFilteredEventsUseCase<List<EventModel>>()),
        Bind.factory((i) => CreateEventUseCase<StatusModel>()),
        Bind.factory((i) => UpdateEventUseCase<StatusModel>()),
        Bind.factory((i) => SubscribeEventUseCase<StatusModel>()),
        Bind.factory((i) => UnsubscribeEventUseCase<StatusModel>()),
        Bind.factory((i) => CreateTeamUseCase<StatusModel>()),
        Bind.factory((i) => JoinTeamUseCase<StatusModel>()),
        Bind.factory((i) => LeaveTeamUseCase<StatusModel>()),
        Bind.factory((i) => DeleteTeamUseCase<StatusModel>()),
        Bind.factory((i) => ToogleSubscriptionsUseCase<StatusModel>()),
        Bind.factory((i) => GetEventUseCase<EventHomeModel>()),
        Bind.factory((i) => GetStandingUseCase<EventStandingsModel>()),
        Bind.factory((i) => RaceStandingsUseCase<RaceStandingsModel>()),
        Bind.factory((i) => TeamsStandingUseCase<EventTeamsStandingsModel>()),
        Bind.factory((i) => StartEventUseCase<StatusModel>()),
        Bind.factory((i) => FinishEventUseCase<StatusModel>()),
        Bind.factory((i) => ToogleMembersOnlyUseCase<StatusModel>()),
        Bind.factory((i) => RemoveRegisterUseCase<StatusModel>()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => SetSummaryUseCase<StatusModel>()),
        Bind.factory((i) => GetSocialMediaUseCase())
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => EventScreen(flow: flow))];
}
