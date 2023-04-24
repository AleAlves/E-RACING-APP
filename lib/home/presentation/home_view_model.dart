import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/presentation/ui/home_flow.dart';
import 'package:e_racing_app/login/legacy/domain/model/profile_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/service/api_exception.dart';
import '../../league/home/domain/model/league_model.dart';
import '../../league/list/domain/fetch_league_usecase.dart';
import '../../notification/domain/get_notifications_count_usecase.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModel with _$HomeViewModel;

abstract class _HomeViewModel with Store {
  _HomeViewModel();

  final fetchUseCase = Modular.get<FetchLeagueUseCase<List<LeagueModel>>>();
  final notificationsCountUC =
      Modular.get<GetNotificationsCountUseCase<String>>();

  @observable
  HomeFlow flow = HomeFlow.error;

  @observable
  ViewState state = ViewState.loading;

  @observable
  ProfileModel? profileModel;

  @observable
  String? notificationsCount;

  @observable
  ObservableList<LeagueModel?>? leagues = ObservableList();

  @observable
  StatusModel? status;

  fetchProfile() {
    state = ViewState.ready;
    profileModel = Session.instance.getUser()?.profile;
  }

  fetchPlayerLeagues() {
    fetchUseCase.invoke(
        success: (data) {
          leagues = ObservableList.of(data!);
          state = ViewState.ready;
        },
        error: () {});
  }

  fetchNotificationsCount() {
    notificationsCountUC.invoke(
        success: (data) {
          notificationsCount = data;
        },
        error: onError);
  }

  void onError(ApiException error) {
    state = ViewState.ready;
  }

  void retry() {
    state = ViewState.ready;
  }
}
