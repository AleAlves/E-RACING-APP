import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:e_racing_app/login/domain/model/status_model.dart';
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
  List<_LeagueViewModel>? leagues;

  @observable
  LeagueModel? league;

  @observable
  StatusModel? status;

  @action
  init() async {
    state = ViewState.ready;
  }

  void retry() {
    state = ViewState.ready;
  }
}
