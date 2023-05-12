import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:e_racing_app/league/update/domain/delete_league_usecase.dart';
import 'package:e_racing_app/league/update/domain/upate_league_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/domain/share_model.dart';
import '../../../core/ext/access_extension.dart';
import '../../../shared/media/get_media.usecase.dart';
import '../../../shared/social/get_social_media_usecase.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../../LeagueRouter.dart';
import '../../core/league_model.dart';
import '../../member/data/league_members_model.dart';
import '../../member/domain/get_members_usecase.dart';
import '../../member/domain/remove_member_usecase.dart';
import '../domain/get_league_usecase.dart';
import '../domain/get_menu_usecase.dart';
import '../domain/get_user_event_use_case.dart';
import '../domain/start_membership_usecase.dart';
import '../domain/stop_membership_usecase.dart';
import 'navigation/league_detail_navigation.dart';

part 'league_detail_view_model.g.dart';

class LeagueDetailViewModel = _LeagueDetailViewModel
    with _$LeagueDetailViewModel;

abstract class _LeagueDetailViewModel
    extends BaseViewModel<LeagueDetailNavigationSet> with Store {
  _LeagueDetailViewModel();

  @observable
  LeagueModel? league;

  @observable
  ShareModel? share;

  @observable
  MediaModel? media;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "";

  @observable
  bool hasMembership = false;

  @observable
  bool? shouldLoadDefaultPoster;

  @override
  @observable
  LeagueDetailNavigationSet? flow = LeagueDetailNavigationSet.main;

  @override
  @observable
  ViewState state = ViewState.ready;

  @observable
  ObservableList<EventModel?>? events = ObservableList();

  @observable
  ObservableList<LeagueModel?>? leagues = ObservableList();

  @observable
  ObservableList<ShortcutModel>? menus = ObservableList();

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<LeagueMembersModel?>? members = ObservableList();

  @observable
  ObservableList<SocialPlatformModel?>? socialMedias = ObservableList();

  final _fetchTagsUC = Modular.get<GetTagUseCase>();
  final _getMediaUseCase = Modular.get<GetMediaUseCase<MediaModel>>();
  final _getSocialMediaUseCase = Modular.get<GetSocialMediaUseCase>();
  final _getMenuUC = Modular.get<GetMenuUseCase<List<ShortcutModel>>>();
  final _getLeagueUseCase = Modular.get<GetLeagueUseCase<LeagueModel>>();
  final _deleteUseCase = Modular.get<DeleteLeagueUseCase<StatusModel>>();
  final _updateUseCase = Modular.get<UpdateLeagueUseCase<StatusModel>>();
  final _startMemberUC = Modular.get<StartMembershipUseCase<StatusModel>>();
  final _stopMembershipUC = Modular.get<StopMembershipUseCase<StatusModel>>();
  final _removeMemberUseCase = Modular.get<RemoveMemberUseCase<StatusModel>>();
  final _memberUC = Modular.get<GetMembersUseCase<List<LeagueMembersModel?>>>();
  final _myEventsUC = Modular.get<GetUserEventUseCase<List<EventModel>>>();

  void update(LeagueModel league, MediaModel media) async {
    state = ViewState.loading;
    await _updateUseCase.params(league: league, media: media).invoke(
        success: (data) {
          status = data;
          onRoute(LeagueDetailNavigationSet.status);
        },
        error: onError);
  }

  void getBanner(String? id) async {
    shouldLoadDefaultPoster = false;
    await _getMediaUseCase.params(id: id).invoke(
        success: (data) {
          media = data;
          if (media?.image == null) {
            shouldLoadDefaultPoster = true;
          }
        },
        error: onError);
  }

  void fetchSocialMedias() async {
    state = ViewState.loading;
    await _getSocialMediaUseCase.invoke(
        success: (data) {
          socialMedias = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  Future<void> getLeague() async {
    state = ViewState.loading;
    league = null;
    media = null;
    fetchSocialMedias();
    await _getLeagueUseCase
        .params(id: Session.instance.getLeagueId().toString())
        .invoke(
            success: (data) {
              getBanner(data?.id);
              league = data;
              hasMembership = isLeagueMember(league);
              share = ShareModel(
                  route: LeagueRouter.detail,
                  leagueId: league?.id,
                  message: "Check out this community",
                  name: league?.name);
              state = ViewState.ready;
            },
            error: onError);
  }

  delete() async {
    state = ViewState.loading;
    _deleteUseCase.params(id: Session.instance.getLeagueId().toString()).invoke(
        success: (data) {
          status = data;
        },
        error: onError);
  }

  startMembership() async {
    state = ViewState.loading;
    _startMemberUC
        .build(leagueId: Session.instance.getLeagueId().toString())
        .invoke(
            success: (data) {
              status = data;
              hasMembership = true;
              _updateMembership(true);
              state = ViewState.ready;
            },
            error: onError);
  }

  Future<void> stopMembership() async {
    state = ViewState.loading;
    _stopMembershipUC
        .build(leagueId: Session.instance.getLeagueId().toString())
        .invoke(
            success: (data) {
              status = data;
              hasMembership = false;
              _updateMembership(false);
              state = ViewState.ready;
            },
            error: onError);
  }

  _updateMembership(bool isMember) {
    hasMembership = isMember;
  }

  void getMenu() {
    _getMenuUC.invoke(
        success: (data) {
          menus = ObservableList.of(data!);
        },
        error: onError);
  }

  void fetchMembers() {
    state = ViewState.loading;
    _memberUC.req(id: league?.id ?? '').invoke(
        success: (data) {
          members = ObservableList.of(data!);
          state = ViewState.ready;
        },
        error: onError);
  }

  void removeMember(String id) {
    state = ViewState.loading;
    _removeMemberUseCase.req(memberId: id, leagueId: league?.id ?? '').invoke(
        success: (data) {
          status = data;
          onRoute(LeagueDetailNavigationSet.status);
        },
        error: onError);
  }

  void deeplink(ShortcutModel? shortcut) {
    if (shortcut?.deepLink != null) {
      Modular.to.pushNamed(shortcut?.deepLink);
    } else if (shortcut?.flow != null) {
      onRoute(shortcut?.flow);
    }
  }

  Future<void> getPlayerEvents() async {
    await _myEventsUC
        .params(leagueId: Session.instance.getLeagueId().toString())
        .invoke(
            success: (data) {
              events = ObservableList.of(data);
            },
            error: onError);
  }

  fetchTags() async {
    state = ViewState.loading;
    await _fetchTagsUC.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  gotToEvent() {
    Modular.to.pushNamed(EventRouter.detail);
  }
}
