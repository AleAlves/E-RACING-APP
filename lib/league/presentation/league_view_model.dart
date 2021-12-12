import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/domain/league_interactor.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:e_racing_app/media/get_media.usecase.dart';
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
  LeagueModel? league;

  @observable
  StatusModel? status;

  final LeagueInteractor _interactor = LeagueInteractorImpl();

  @action
  init() async {
    state = ViewState.ready;
  }

  void fetch() async {
    state = ViewState.loading;
    await _interactor.fetch((list) async {
      state = ViewState.ready;
      for (var i = 0; i < list.length; i++) {
        var media = await getMedia(list[i].id, i);
        medias?.insert(i, media);
      }
      leagues = ObservableList.of(list);
    }, (error) {
      state = ViewState.error;
    });
  }

  void create(String name, String description, String banner64) {
    state = ViewState.loading;
    _interactor.create(name, description, banner64, () {
      status = StatusModel("League Created", "Ok", next: LeagueFlow.list);
      state = ViewState.ready;
      flow = LeagueFlow.status;
    }, (error) {
      state = ViewState.error;
    });
  }

  Future<MediaModel> getMedia(String? id, int index) async {
    return await GetMediaUseCase().invoke(id ?? '');
  }

  void retry() {
    state = ViewState.ready;
  }
}
