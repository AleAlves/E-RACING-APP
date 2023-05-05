import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/presentation/router/home_router.dart';
import 'package:e_racing_app/profile/data/profile_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../league/list/data/league_model.dart';
import '../../league/list/domain/fetch_league_usecase.dart';
import '../../push/domain/get_notifications_count_usecase.dart';
import '../../shared/media/get_media.usecase.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModel with _$HomeViewModel;

abstract class _HomeViewModel extends BaseViewModel<HomeRouter> with Store {
  _HomeViewModel();

  @override
  @observable
  HomeRouter? flow = HomeRouter.main;

  @override
  @observable
  ViewState state = ViewState.loading;

  @observable
  ProfileModel? profileModel;

  @observable
  String? notificationsCount;

  @observable
  ObservableList<Pair<LeagueModel?, MediaModel>?> leagues = ObservableList();

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "E-Racing";

  final _getMediaUseCase = Modular.get<GetMediaUseCase<MediaModel>>();
  final _fetchUseCase = Modular.get<FetchLeagueUseCase<List<LeagueModel>>>();
  final _notificationUC = Modular.get<GetNotificationsCountUseCase<String>>();

  getProfile() {
    profileModel = Session.instance.getUser()?.profile;
    state = ViewState.ready;
  }

  getPlayerLeagues() {
    leagues.clear();
    _fetchUseCase.invoke(
        success: (data) {
          ObservableList.of(data!).asMap().forEach((index, element) {
            leagues.add(Pair(element, null));
            _getMedia(index, element.id);
          });
        },
        error: () {});
  }

  getNotificationsCount() {
    _notificationUC.invoke(
        success: (data) {
          notificationsCount = data;
        },
        error: onError);
  }

  _getMedia(int index, String? id) async {
    await _getMediaUseCase.params(id: id).invoke(
        success: (data) {
          leagues[index]?.second = data;
        },
        error: () {});
  }
}
