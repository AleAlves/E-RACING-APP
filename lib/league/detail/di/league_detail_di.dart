import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/event_model.dart';
import '../../../core/model/media_model.dart';
import '../../../core/model/shortcut_model.dart';
import '../../../core/model/status_model.dart';
import '../../../media/get_media.usecase.dart';
import '../../../social/get_social_media_usecase.dart';
import '../../../tag/get_tag_usecase.dart';
import '../../home/data/league_members_model.dart';
import '../../home/domain/fetch_league_menu_usecase.dart';
import '../../home/domain/fetch_player_events_use_case.dart';
import '../../home/domain/get_league_usecase.dart';
import '../../home/domain/get_members_usecase.dart';
import '../../home/domain/model/league_model.dart';
import '../../home/domain/remove_member_usecase.dart';
import '../../home/domain/start_membership_usecase.dart';
import '../../home/domain/stop_membership_usecase.dart';
import '../../update/domain/delete_league_usecase.dart';
import '../../update/domain/upate_league_usecase.dart';
import '../presentation/league_detail_screen.dart';
import '../presentation/league_detail_view_model.dart';
import '../presentation/navigation/league_detail_navigation.dart';

class LeagueDetailModule extends Module {
  final LeagueDetailNavigationSet flow;

  LeagueDetailModule({this.flow = LeagueDetailNavigationSet.main});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => LeagueDetailViewModel()),
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
        ChildRoute('/', child: (context, args) => const LeagueDetailScreen()),
      ];
}
