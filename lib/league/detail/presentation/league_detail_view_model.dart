import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
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
import '../../list/data/league_model.dart';
import '../../member/data/league_members_model.dart';
import '../../member/domain/get_members_usecase.dart';
import '../../member/domain/remove_member_usecase.dart';
import '../domain/fetch_league_menu_usecase.dart';
import '../domain/fetch_player_events_use_case.dart';
import '../domain/get_league_usecase.dart';
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
  bool membershipIsReady = false;

  @override
  @observable
  LeagueDetailNavigationSet? flow = LeagueDetailNavigationSet.main;

  @override
  @observable
  ViewState state = ViewState.ready;

  @observable
  ObservableList<EventModel?>? playerEvents = ObservableList();

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

  final updateUseCase = Modular.get<UpdateLeagueUseCase<StatusModel>>();
  final removeMemberUseCase = Modular.get<RemoveMemberUseCase<StatusModel>>();
  final getMediaUseCase = Modular.get<GetMediaUseCase<MediaModel>>();
  final getTagUseCase = Modular.get<GetTagUseCase>();
  final getSocialMediaUseCase = Modular.get<GetSocialMediaUseCase>();
  final getLeagueMediaUseCase = Modular.get<GetLeagueUseCase<LeagueModel>>();
  final deleteUseCase = Modular.get<DeleteLeagueUseCase<StatusModel>>();
  final startMembershipUseCase =
      Modular.get<StartMembershipUseCase<StatusModel>>();
  final stopMembershipUseCase =
      Modular.get<StopMembershipUseCase<StatusModel>>();
  final fetchMenuUsecase =
      Modular.get<FetchLeagueMenuUseCase<List<ShortcutModel>>>();
  final fetchMemberUseCase =
      Modular.get<FetchMembersUseCase<List<LeagueMembersModel?>>>();
  final fetchPlayersEventUseCase =
      Modular.get<FetchPlayerEventsUseCase<List<EventModel>>>();

  void update(LeagueModel league, MediaModel media) async {
    state = ViewState.loading;
    await updateUseCase.params(league: league, media: media).invoke(
        success: (data) {
          status = data;
          onRoute(LeagueDetailNavigationSet.status);
        },
        error: onError);
  }

  void getMedia(String id) async {
    await getMediaUseCase.params(id: id).invoke(
        success: (data) {
          media = data;
        },
        error: onError);
  }

  void fetchSocialMedias() async {
    state = ViewState.loading;
    await getSocialMediaUseCase.invoke(
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
    await getLeagueMediaUseCase
        .params(id: Session.instance.getLeagueId().toString())
        .invoke(
            success: (data) {
              league = data;
              membershipIsReady = true;
              hasMembership = hasLeagueMembership(league);
              share = ShareModel(
                  route: LeagueRouter.detail,
                  leagueId: league?.id,
                  message: "Check out this community",
                  name: league?.name);
              // getMedia(data?.id ?? '');
              state = ViewState.ready;
            },
            error: onError);
  }

  Future<void> delete() async {
    state = ViewState.loading;
    deleteUseCase.params(id: Session.instance.getLeagueId().toString()).invoke(
        success: (data) {
          status = data;
        },
        error: onError);
  }

  Future<void> startMembership() async {
    membershipIsReady = false;
    startMembershipUseCase
        .build(leagueId: Session.instance.getLeagueId().toString())
        .invoke(
            success: (data) {
              status = data;
              _updateMembership(true);
            },
            error: onError);
  }

  Future<void> stopMembership() async {
    membershipIsReady = false;
    stopMembershipUseCase
        .build(leagueId: Session.instance.getLeagueId().toString())
        .invoke(
            success: (data) {
              status = data;
              _updateMembership(false);
            },
            error: onError);
  }

  _updateMembership(bool isMember) {
    hasMembership = isMember;
    membershipIsReady = true;
  }

  void getMenu() {
    fetchMenuUsecase.invoke(
        success: (data) {
          menus = ObservableList.of(data!);
        },
        error: onError);
  }

  void fetchMembers() {
    state = ViewState.loading;
    fetchMemberUseCase.req(id: league?.id ?? '').invoke(
        success: (data) {
          members = ObservableList.of(data!);
          state = ViewState.ready;
        },
        error: onError);
  }

  void removeMember(String id) {
    state = ViewState.loading;
    removeMemberUseCase.req(memberId: id, leagueId: league?.id ?? '').invoke(
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
    await fetchPlayersEventUseCase
        .params(leagueId: Session.instance.getLeagueId().toString())
        .invoke(
            success: (data) {
              playerEvents = ObservableList.of(data);
            },
            error: onError);
  }
}
