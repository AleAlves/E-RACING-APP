import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/event/domain/create_event_usecase.dart';
import 'package:e_racing_app/event/domain/create_team_usecase.dart';
import 'package:e_racing_app/event/domain/delete_team_usecase.dart';
import 'package:e_racing_app/event/domain/join_team_usecase.dart';
import 'package:e_racing_app/event/domain/leave_team_usecase.dart';
import 'package:e_racing_app/event/domain/subscribe_event_usecase.dart';
import 'package:e_racing_app/event/domain/fetch_events_use_case.dart';
import 'package:e_racing_app/event/domain/get_event_usecase.dart';
import 'package:e_racing_app/event/domain/unsubscribe_event_usecase.dart';
import 'package:e_racing_app/event/event_view_model.dart';
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
        Bind.factory((i) => SubscribeEventUseCase<StatusModel>()),
        Bind.factory((i) => UnsubscribeEventUseCase<StatusModel>()),
        Bind.factory((i) => CreateTeamUseCase<StatusModel>()),
        Bind.factory((i) => JoinTeamUseCase<StatusModel>()),
        Bind.factory((i) => LeaveTeamUseCase<StatusModel>()),
        Bind.factory((i) => DeleteTeamUseCase<StatusModel>()),
        Bind.factory((i) => GetEventUseCase<EventModel>()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => GetSocialMediaUseCase())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const EventScreen()),
      ];
}
