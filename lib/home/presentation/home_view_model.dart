import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/presentation/router/home_router.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../league/LeagueRouter.dart';
import '../../league/core/league_model.dart';
import '../../profile/ProfileRouter.dart';
import '../../profile/domain/model/profile_model.dart';
import '../../push/PushRouter.dart';
import '../../push/domain/get_notifications_count_usecase.dart';
import '../../shared/media/get_media.usecase.dart';
import '../domain/get_user_league_use_case.dart';
import '../domain/model/community_card_vo.dart';

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
  MediaModel? picture;

  @observable
  ObservableList<CommunityCardVO?>? communities;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "Pitlane Dash";

  final _getMediaUseCase = Modular.get<GetMediaUseCase<MediaModel?>>();
  final _notificationUC = Modular.get<GetNotificationsCountUseCase<String>>();
  final _leagueUseCase = Modular.get<GetUserLeagueUseCase<List<LeagueModel>>>();

  getProfile() {
    var user = Session.instance.getUser();
    profileModel = user?.profile;
    state = ViewState.ready;
    _getMedia(user?.id);
  }

  getPlayerLeagues() {
    communities = null;
    _leagueUseCase.invoke(
        success: (data) {
          communities = ObservableList();
          ObservableList.of(data!).asMap().forEach((index, element) {
            communities?.add(CommunityCardVO(
                leagueId: element.id, name: element.name, media: null));
            _getLeaguesMedia(index, element.id);
          });
        },
        failure: () {});
  }

  getNotificationsCount() {
    _notificationUC.invoke(
        success: (data) {
          notificationsCount = data;
        },
        failure: () {});
  }

  _getLeaguesMedia(int index, String? id) async {
    await _getMediaUseCase.params(id: id).invoke(
        success: (data) {
          var name = communities?[index]?.name;
          var id = communities?[index]?.leagueId;
          communities?[index] =
              CommunityCardVO(leagueId: id, name: name, media: data);
        },
        failure: () {});
  }

  _getMedia(String? id) async {
    await _getMediaUseCase.params(id: id).invoke(
        success: (data) {
          picture = data;
        },
        failure: () {});
  }

  goToLeague(String? leagueId) {
    Session.instance.setLeagueId(leagueId);
    Modular.to.pushNamed(LeagueRouter.detail);
  }

  goToProfile() {
    Modular.to.pushNamed(ProfileRouter.main);
  }

  goToPushNotifications() {
    Modular.to.pushNamed(PushRouter.main);
  }
}
