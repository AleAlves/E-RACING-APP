import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/event/data/event_home_model.dart';
import 'package:e_racing_app/event/data/event_standings_model.dart';
import 'package:e_racing_app/event/data/race_standings_model.dart';
import 'package:e_racing_app/event/domain/create_event_usecase.dart';
import 'package:e_racing_app/event/domain/create_team_usecase.dart';
import 'package:e_racing_app/event/domain/delete_team_usecase.dart';
import 'package:e_racing_app/event/domain/finish_event_usecase.dart';
import 'package:e_racing_app/event/domain/get_event_standing_usecase.dart';
import 'package:e_racing_app/event/domain/get_race_standing_usecase.dart';
import 'package:e_racing_app/event/domain/join_team_usecase.dart';
import 'package:e_racing_app/event/domain/leave_team_usecase.dart';
import 'package:e_racing_app/event/domain/remove_subcription_usecase.dart';
import 'package:e_racing_app/event/domain/set_result_event_usecase.dart';
import 'package:e_racing_app/event/domain/start_event_usecase.dart';
import 'package:e_racing_app/event/domain/subscribe_event_usecase.dart';
import 'package:e_racing_app/event/domain/fetch_events_use_case.dart';
import 'package:e_racing_app/event/domain/get_event_usecase.dart';
import 'package:e_racing_app/event/domain/toogle_members_only_usecase.dart';
import 'package:e_racing_app/event/domain/toogle_subscriptions_usecase.dart';
import 'package:e_racing_app/event/domain/unsubscribe_event_usecase.dart';
import 'package:e_racing_app/event/domain/update_event_usecase.dart';
import 'package:e_racing_app/event/event_view_model.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:e_racing_app/event/presentation/ui/event_screen.dart';
import 'package:e_racing_app/media/get_media.usecase.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EventModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => EventViewModel()),
        Bind.factory((i) => GetMediaUseCase<MediaModel>()),
        Bind.factory((i) => FetchEventsUseCase<List<EventModel>>()),
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
        Bind.factory((i) => GetEventStandingUseCase<EventStandingsModel>()),
        Bind.factory((i) => GetRaceStandingsUseCase<RaceStandingsModel>()),
        Bind.factory((i) => StartEventUseCase<StatusModel>()),
        Bind.factory((i) => FinishEventUseCase<StatusModel>()),
        Bind.factory((i) => ToogleMembersOnlyUseCase<StatusModel>()),
        Bind.factory((i) => RemoveSubscriptionUseCase<StatusModel>()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => SetSummaryUseCase<StatusModel>()),
        Bind.factory((i) => GetSocialMediaUseCase())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => EventScreen(flows: args.data))
      ];
}
