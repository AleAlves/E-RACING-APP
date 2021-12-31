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

  final DeleteLeagueUseCase _delete = DeleteLeagueUseCase();
  final UpdateLeagueUseCase _update = UpdateLeagueUseCase();
  final CreateLeagueUseCase _create = CreateLeagueUseCase();
  final GetLeagueUseCase _get = GetLeagueUseCase();

  @action
  init() async {
    state = ViewState.ready;
  }

  void fetchLeagues() async {
    state = ViewState.loading;
    FetchLeagueUseCase<List<LeagueModel>>().invoke(
        success: (data) {
          leagues = ObservableList.of(data);
        },
        error: onError);
    state = ViewState.ready;
  }

  Future<void> create(String name, String description, String banner,
      String emblem, List<String?> tags, List<LinkModel?> links) async {
    // state = ViewState.loading;
    // var response = await _create.invoke(
    //     LeagueModel(
    //         name: name,
    //         description: description,
    //         emblem: emblem,
    //         tags: tags,
    //         links: links),
    //     MediaModel(banner));
    // if (response.isSuccessfully) {
    //   status = StatusModel("League Created", "Ok", next: LeagueFlow.list);
    //   setFlow(LeagueFlow.status);
    // } else {
    //   state = ViewState.error;
    // }
  }

  void update(LeagueModel league, MediaModel media) async {
    state = ViewState.loading;
    // var response = await _update.invoke(league, media);
    // if (response.isSuccessfully) {
    //   status = StatusModel("League Updated", "Ok", next: LeagueFlow.list);
    //   setFlow(LeagueFlow.status);
    // } else {
    //   state = ViewState.error;
    // }
  }

  Future<MediaModel> getMedia(String? id, int index) async {
    //return await GetMediaUseCase().invoke(id ?? '');
    return MediaModel.fromJson({});
  }

  void fetchTags() async {
    state = ViewState.loading;
    //var response = await GetTagUseCase().invoke();
    //tags = ObservableList.of(response);
    state = ViewState.ready;
  }

  void fetchSocialMedias() async {
    state = ViewState.loading;
    //var response = await GetSocialMediaUseCase().invoke();
    //socialMedias = ObservableList.of(response);
    state = ViewState.ready;
  }

  Future<void> getLeague() async {
    state = ViewState.loading;
    fetchTags();
    fetchSocialMedias();
    //media = await GetMediaUseCase().invoke(id.toString());
    // var response = await _get.invoke(id.toString());
    // response.isSuccessfully
    //     ? league = LeagueModel.fromJson(response.data)
    //     : state = ViewState.error;

    state = ViewState.ready;
  }

  Future<void> delete() async {
    state = ViewState.loading;
    // var response = await _delete.invoke(id.toString());
    // if (response.isSuccessfully) {
    //   status = StatusModel("League Deleted", "Ok", next: LeagueFlow.list);
    //   setFlow(LeagueFlow.status);
    // } else {
    //   state = ViewState.error;
    // }
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
