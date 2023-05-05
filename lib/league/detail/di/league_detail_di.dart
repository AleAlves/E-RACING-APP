import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/event_model.dart';
import '../../../core/model/media_model.dart';
import '../../../core/model/shortcut_model.dart';
import '../../../core/model/status_model.dart';
import '../../../shared/media/get_media.usecase.dart';
import '../../../shared/social/get_social_media_usecase.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../../list/data/league_model.dart';
import '../../member/data/league_members_model.dart';
import '../../member/domain/get_members_usecase.dart';
import '../../member/domain/remove_member_usecase.dart';
import '../../update/domain/delete_league_usecase.dart';
import '../../update/domain/upate_league_usecase.dart';
import '../domain/get_league_usecase.dart';
import '../domain/get_menu_usecase.dart';
import '../domain/get_user_event_use_case.dart';
import '../domain/start_membership_usecase.dart';
import '../domain/stop_membership_usecase.dart';
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
        Bind.factory((i) => GetUserEventUseCase<List<EventModel>>()),
        Bind.factory((i) => UpdateLeagueUseCase<StatusModel>()),
        Bind.factory((i) => StartMembershipUseCase<StatusModel>()),
        Bind.factory((i) => StopMembershipUseCase<StatusModel>()),
        Bind.factory((i) => RemoveMemberUseCase<StatusModel>()),
        Bind.factory((i) => GetMediaUseCase<MediaModel>()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => GetSocialMediaUseCase()),
        Bind.factory((i) => GetLeagueUseCase<LeagueModel>()),
        Bind.factory((i) => GetMembersUseCase<List<LeagueMembersModel>>()),
        Bind.factory((i) => DeleteLeagueUseCase<StatusModel>()),
        Bind.factory((i) => GetMenuUseCase<List<ShortcutModel>>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LeagueDetailScreen()),
      ];
}
