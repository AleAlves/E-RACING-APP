import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/home/presentation/ui/home_flow.dart';
import 'package:e_racing_app/login/domain/model/status_model.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModel with _$HomeViewModel;

abstract class _HomeViewModel with Store {
  _HomeViewModel();

  @observable
  HomeFlow flow = HomeFlow.error;

  @observable
  ViewState state = ViewState.loading;

  @observable
  List<LeagueModel>? leagues;

  @observable
  StatusModel? status;

  @action
  init() async {
    state = ViewState.loading;
  }

  void retry() {
    state = ViewState.ready;
  }
}
