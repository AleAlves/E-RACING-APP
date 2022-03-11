import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/data/league_members_model.dart';
import 'package:e_racing_app/league/domain/fetch_player_events_use_case.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';
import 'package:e_racing_app/league/domain/fetch_league_usecase.dart';
import 'package:e_racing_app/league/domain/get_members_usecase.dart';
import 'package:e_racing_app/league/domain/remove_member_usecase.dart';
import 'package:e_racing_app/league/domain/start_membership_usecase.dart';
import 'package:e_racing_app/league/domain/stop_membership_usecase.dart';
import 'package:e_racing_app/league/domain/create_league_usecase.dart';
import 'package:e_racing_app/league/domain/delete_league_usecase.dart';
import 'package:e_racing_app/league/domain/fetch_league_menu_usecase.dart';
import 'package:e_racing_app/league/domain/get_league_usecase.dart';
import 'package:e_racing_app/league/domain/upate_league_usecase.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:e_racing_app/media/get_media.usecase.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'league_view_model.g.dart';

class LeagueViewModel = _LeagueViewModel with _$LeagueViewModel;

abstract class _LeagueViewModel with Store {
  _LeagueViewModel();

  @observable
  LeagueModel? league;

  @observable
  MediaModel? media;

  @observable
  StatusModel? status;

  @observable
  LeagueFlow flow = LeagueFlow.list;

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

  final fetchUseCase = Modular.get<FetchLeagueUseCase<List<LeagueModel>>>();
  final createUseCase = Modular.get<CreateLeagueUseCase<StatusModel>>();
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

  void fetchLeagues() async {
    state = ViewState.loading;
    getMenu();
    fetchTags();
    fetchSocialMedias();
    fetchUseCase.invoke(
        success: (data) {
          leagues = ObservableList.of(data!);
          state = ViewState.ready;
        },
        error: onError);
  }

  Future<void> create(String name, String description, String banner,
      String emblem, List<String?> tags, List<LinkModel?> links) async {
    state = ViewState.loading;
    await createUseCase
        .build(
            league: LeagueModel(
                name: name,
                description: description,
                emblem: emblem,
                tags: tags,
                links: links),
            media: MediaModel(banner))
        .invoke(
            success: (data) {
              status = data;
              setFlow(LeagueFlow.status);
            },
            error: onError);
  }

  void update(LeagueModel league, MediaModel media) async {
    state = ViewState.loading;
    await updateUseCase.params(league: league, media: media).invoke(
        success: (data) {
          status = data;
          setFlow(LeagueFlow.status);
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

  void fetchTags() async {
    state = ViewState.loading;
    await getTagUseCase.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          state = ViewState.ready;
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
    fetchTags();
    fetchSocialMedias();
    await getLeagueMediaUseCase
        .params(id: Session.instance.getLeagueId().toString())
        .invoke(
            success: (data) {
              league = data;
              getMedia(data?.id ?? '');
              state = ViewState.ready;
            },
            error: onError);
  }

  Future<void> delete() async {
    state = ViewState.loading;
    deleteUseCase.params(id: Session.instance.getLeagueId().toString()).invoke(
        success: (data) {
          status = data;
          setFlow(LeagueFlow.status);
        },
        error: onError);
  }

  Future<void> startMembership() async {
    state = ViewState.loading;
    startMembershipUseCase.build(leagueId: Session.instance.getLeagueId().toString()).invoke(
        success: (data) {
          status = data;
          setFlow(LeagueFlow.status);
        },
        error: onError);
  }

  Future<void> stopMembership() async {
    state = ViewState.loading;
    stopMembershipUseCase.build(leagueId: Session.instance.getLeagueId().toString()).invoke(
        success: (data) {
          status = data;
          setFlow(LeagueFlow.status);
        },
        error: onError);
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
          setFlow(LeagueFlow.status);
        },
        error: onError);
  }

  void deeplink(ShortcutModel? shortcut) {
    if (shortcut?.deepLink != null) {
      Modular.to.pushNamed(shortcut?.deepLink ?? '');
    } else if (shortcut?.flow != null) {
      setFlow(shortcut?.flow);
    }
  }

  Future<void> getPlayerEvents() async {
    await fetchPlayersEventUseCase.params(leagueId: Session.instance.getLeagueId().toString()).invoke(
        success: (data) {
          playerEvents = ObservableList.of(data);
        },
        error: onError);
  }

  void onError() {
    status = StatusModel(
      message: "Something went wrong",
      action: "Ok",
      next: LeagueFlow.list,
      previous: flow,
    );
    state = ViewState.ready;
    flow = LeagueFlow.status;
  }

  void setFlow(LeagueFlow flow) {
    this.flow = flow;
  }
}
