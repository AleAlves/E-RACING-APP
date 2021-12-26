import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/domain/league_interactor.dart';
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

  final LeagueInteractor _interactor = LeagueInteractorImpl();

  @action
  init() async {
    state = ViewState.ready;
  }

  void fetchLeagues() async {
    state = ViewState.loading;
    await _interactor.fetch((list) async {
      state = ViewState.ready;
      leagues = ObservableList.of(list);
    }, (error) {
      state = ViewState.error;
    });
  }

  void create(String name, String description, String banner, String emblem,
      List<String?> tags, List<LinkModel?> links) {
    state = ViewState.loading;
    _interactor.create(name, description, banner, emblem, tags, links, () {
      status = StatusModel("League Created", "Ok", next: LeagueFlow.list);
      state = ViewState.ready;
      setFlow(LeagueFlow.status);
    }, (error) {
      state = ViewState.error;
    });
  }

  void update(LeagueModel league, MediaModel media) {
    state = ViewState.loading;
    _interactor.update(media, league, () {
      status = StatusModel("League Created", "Ok", next: LeagueFlow.list);
      state = ViewState.ready;
      setFlow(LeagueFlow.status);
    }, (error) {
      state = ViewState.error;
    });
  }

  Future<MediaModel> getMedia(String? id, int index) async {
    return await GetMediaUseCase().invoke(id ?? '');
  }

  void fetchTags() async {
    state = ViewState.loading;
    tags = ObservableList.of(await GetTagUseCase().invoke());
    state = ViewState.ready;
  }

  void fetchSocialMedias() async {
    socialMedias = ObservableList.of(await GetSocialMediaUseCase().invoke());
  }

  Future<void> getLeague() async {
    state = ViewState.loading;
    league = await _interactor.get(id ?? '');
    media = await GetMediaUseCase().invoke(league?.id ?? '');
    state = ViewState.ready;
  }

  void retry() {
    state = ViewState.ready;
  }

  void setFlow(LeagueFlow flow) {
    this.flow = flow;
  }
}
