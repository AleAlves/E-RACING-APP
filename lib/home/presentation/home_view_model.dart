import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/presentation/ui/home_flow.dart';
import 'package:e_racing_app/league/domain/fetch_league_usecase.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModel with _$HomeViewModel;

abstract class _HomeViewModel with Store {
  _HomeViewModel();

  final fetchUseCase = Modular.get<FetchLeagueUseCase<List<LeagueModel>>>();

  @observable
  HomeFlow flow = HomeFlow.error;

  @observable
  ViewState state = ViewState.loading;

  @observable
  ProfileModel? profileModel;

  @observable
  ObservableList<LeagueModel?>? leagues = ObservableList();

  @observable
  StatusModel? status;

  fetchProfile(){
    state = ViewState.ready;
    profileModel = Session.instance.getUser()?.profile;
  }

  fetchPlayerLeagues(){
    fetchUseCase.invoke(
        success: (data) {
          leagues = ObservableList.of(data!);
          state = ViewState.ready;
        },
        error: (){});
  }

  void retry() {
    state = ViewState.ready;
  }
}
