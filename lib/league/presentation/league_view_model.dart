import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/domain/usecase/create_league_usecase.dart';
import 'package:e_racing_app/league/domain/usecase/delete_league_usecase.dart';
import 'package:e_racing_app/league/domain/usecase/fetch_league_usecase.dart';
import 'package:e_racing_app/league/domain/usecase/get_league_usecase.dart';
import 'package:e_racing_app/league/domain/usecase/upate_league_usecase.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:e_racing_app/media/get_media.usecase.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:mobx/mobx.dart';

part 'league_view_model.g.dart';

class LeagueViewModel = _LeagueViewModel with _$LeagueViewModel;

abstract class _LeagueViewModel with Store {
  _LeagueViewModel();

  @observable
  LeagueFlow flow = LeagueFlow.list;

  @observable
  ViewState state = ViewState.ready;

  @observable
  ObservableList<LeagueModel?>? leagues = ObservableList();

  @observable
  ObservableList<MediaModel?>? medias = ObservableList();

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<Map<String, TagModel?>>? leaguesTags = ObservableList();

  @observable
  ObservableList<SocialPlatformModel?>? socialMedias = ObservableList();

  @observable
  LeagueModel? league;

  @observable
  MediaModel? media;

  @observable
  String? id;

  @observable
  StatusModel? status;

  @action
  init() async {
    state = ViewState.ready;
  }

  void fetchLeagues() async {
    state = ViewState.loading;
    fetchTags();
    fetchSocialMedias();
    FetchLeagueUseCase<List<LeagueModel>>().invoke(
        success: (data) {
          leagues = ObservableList.of(data!);
        },
        error: onError);
    state = ViewState.ready;
  }

  Future<void> create(String name, String description, String banner,
      String emblem, List<String?> tags, List<LinkModel?> links) async {
    state = ViewState.loading;
    await CreateLeagueUseCase<bool>(
            league: LeagueModel(
                name: name,
                description: description,
                emblem: emblem,
                tags: tags,
                links: links),
            media: MediaModel(banner))
        .invoke(
            success: (data) {
              status =
                  StatusModel("League Created", "Ok", next: LeagueFlow.list);
              setFlow(LeagueFlow.status);
            },
            error: onError);
  }

  void update(LeagueModel league, MediaModel media) async {
    state = ViewState.loading;
    await UpdateLeagueUseCase(league: league, media: media).invoke(
        success: (data) {
          status = StatusModel("League Updated", "Ok", next: LeagueFlow.list);
          setFlow(LeagueFlow.status);
        },
        error: onError);
  }

  void getMedia(String id) async {
    await GetMediaUseCase<MediaModel>(id: id).invoke(
        success: (data) {
          media = data;
        },
        error: onError);
  }

  void fetchTags() async {
    state = ViewState.loading;
    await GetTagUseCase().invoke(
        success: (data) {
          tags = ObservableList.of(data);
        },
        error: onError);
    ;
    state = ViewState.ready;
  }

  void fetchSocialMedias() async {
    state = ViewState.loading;
    await GetSocialMediaUseCase().invoke(
        success: (data) {
          socialMedias = ObservableList.of(data);
        },
        error: onError);
    state = ViewState.ready;
  }

  Future<void> getLeague() async {
    state = ViewState.loading;
    fetchTags();
    fetchSocialMedias();
    await GetLeagueUseCase<LeagueModel>(id: id.toString()).invoke(
        success: (data) {
          getMedia(data?.id ?? '');
          league = data;
        },
        error: onError);
    state = ViewState.ready;
  }

  Future<void> delete() async {
    state = ViewState.loading;
    DeleteLeagueUseCase<bool>(id: id.toString()).invoke(
        success: (data) {
          status = StatusModel("League Deleted", "Ok", next: LeagueFlow.list);
          setFlow(LeagueFlow.status);
        },
        error: onError);
  }

  void retry() {
    state = ViewState.ready;
  }

  void onError(ApiException error) {
    status = StatusModel(error.message(), "Ok",
        next: LeagueFlow.list, previous: flow);

    if (error.isBusiness()) {
      state = ViewState.ready;
      flow = LeagueFlow.status;
    } else {
      state = ViewState.error;
    }
  }

  void setFlow(LeagueFlow flow) {
    this.flow = flow;
  }
}
