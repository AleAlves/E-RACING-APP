import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/league/create/domain/create_league_usecase.dart';
import 'package:e_racing_app/league/update/domain/delete_league_usecase.dart';
import 'package:e_racing_app/league/update/domain/upate_league_usecase.dart';
import 'package:e_racing_app/media/get_media.usecase.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/league_members_model.dart';
import '../domain/fetch_league_menu_usecase.dart';
import '../domain/fetch_league_usecase.dart';
import '../domain/fetch_player_events_use_case.dart';
import '../domain/get_league_usecase.dart';
import '../domain/get_members_usecase.dart';
import '../domain/model/league_model.dart';
import '../domain/remove_member_usecase.dart';
import '../domain/start_membership_usecase.dart';
import '../domain/stop_membership_usecase.dart';
import '../presentation/league_view_model.dart';
import '../presentation/ui/league_screen.dart';
import '../presentation/ui/navigation/league_flow.dart';

class LeagueModule extends Module {
  final LeagueFlow flow;

  LeagueModule({this.flow = LeagueFlow.list});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => LeagueViewModel()),
        Bind.factory((i) => CreateLeagueUseCase<StatusModel>()),
        Bind.factory((i) => FetchLeagueUseCase<List<LeagueModel>>()),
        Bind.factory((i) => FetchPlayerEventsUseCase<List<EventModel>>()),
        Bind.factory((i) => UpdateLeagueUseCase<StatusModel>()),
        Bind.factory((i) => StartMembershipUseCase<StatusModel>()),
        Bind.factory((i) => StopMembershipUseCase<StatusModel>()),
        Bind.factory((i) => RemoveMemberUseCase<StatusModel>()),
        Bind.factory((i) => GetMediaUseCase<MediaModel>()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => GetSocialMediaUseCase()),
        Bind.factory((i) => GetLeagueUseCase<LeagueModel>()),
        Bind.factory((i) => FetchMembersUseCase<List<LeagueMembersModel>>()),
        Bind.factory((i) => DeleteLeagueUseCase<StatusModel>()),
        Bind.factory((i) => FetchLeagueMenuUseCase<List<ShortcutModel>>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => LeagueScreen(flow)),
      ];
}