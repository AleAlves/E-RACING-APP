import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/event_model.dart';
import '../../../core/model/media_model.dart';
import '../../../core/model/shortcut_model.dart';
import '../../../core/model/status_model.dart';
import '../../../shared/media/get_media.usecase.dart';
import '../../../shared/social/get_social_media_usecase.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../../core/league_model.dart';
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
  void binds(i) {
    i.add<LeagueDetailViewModel>(LeagueDetailViewModel.new);
    i.add<GetUserEventUseCase<List<EventModel>>>(GetUserEventUseCase.new);
    i.add<UpdateLeagueUseCase<StatusModel>>(UpdateLeagueUseCase.new);
    i.add<StartMembershipUseCase<StatusModel>>(StartMembershipUseCase.new);
    i.add<StopMembershipUseCase<StatusModel>>(StopMembershipUseCase.new);
    i.add<RemoveMemberUseCase<StatusModel>>(RemoveMemberUseCase.new);
    i.add<GetMediaUseCase<MediaModel>>(GetMediaUseCase.new);
    i.add<GetTagUseCase>(GetTagUseCase.new);
    i.add<GetSocialMediaUseCase>(GetSocialMediaUseCase.new);
    i.add<GetLeagueUseCase<LeagueModel>>(GetLeagueUseCase.new);
    i.add<GetMembersUseCase<List<LeagueMembersModel>>>(GetMembersUseCase.new);
    i.add<DeleteLeagueUseCase<StatusModel>>(DeleteLeagueUseCase.new);
    i.add<GetMenuUseCase<List<ShortcutModel>>>(GetMenuUseCase.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LeagueDetailScreen());
  }
}
