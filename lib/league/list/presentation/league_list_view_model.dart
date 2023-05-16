import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/league/list/domain/search_league_usecase.dart';
import 'package:e_racing_app/league/list/presentation/router/league_list_router.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/model/tag_model.dart';
import '../../../core/ui/view_state.dart';
import '../../../event/event_router.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../../core/league_model.dart';
import '../domain/fetch_league_usecase.dart';
import '../domain/get_owned_league_usecase.dart';

part 'league_list_view_model.g.dart';

class LeagueListViewModel = _LeagueListViewModel with _$LeagueListViewModel;

abstract class _LeagueListViewModel extends BaseViewModel<LeagueListRouterSet>
    with Store {
  _LeagueListViewModel();

  @override
  @observable
  LeagueListRouterSet? flow = LeagueListRouterSet.main;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "Communities";

  @observable
  bool loginAutomatically = true;

  @observable
  List<String>? searchTags = [];

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<LeagueModel?>? leagues = ObservableList();

  final _fetchTagsUC = Modular.get<GetTagUseCase>();
  final _fetchListUC = Modular.get<FetchLeagueUseCase<List<LeagueModel>>>();
  final _searchListUC = Modular.get<SearchLeagueUseCase<List<LeagueModel>>>();
  final _ownedListUC = Modular.get<GetOwnedLeagueUseCase<List<LeagueModel>>>();

  getLeagues() async {
    state = ViewState.loading;
    _fetchListUC.invoke(
        success: (data) {
          leagues = ObservableList.of(data!);
          _fetchTags();
        },
        failure: onError);
  }

  getOwnedLeagues() async {
    state = ViewState.loading;
    _ownedListUC.invoke(
        success: (data) {
          leagues = ObservableList.of(data!);
          if (leagues?.length == 1) {
            skipLeagueSelection(leagues?.first?.id);
          } else {
            title = "Your communities";
          }
          state = ViewState.ready;
        },
        failure: onError);
  }

  searchEvents() async {
    state = ViewState.loading;
    _searchListUC.build(tagIds: searchTags).invoke(
        success: (data) {
          leagues = ObservableList.of(data!);
          state = ViewState.ready;
        },
        failure: onError);
  }

  _fetchTags() async {
    state = ViewState.loading;
    await _fetchTagsUC.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          state = ViewState.ready;
        },
        failure: onError);
  }

  getUser() async {
    state = ViewState.loading;
  }

  skipLeagueSelection(String? id) {
    Session.instance.setLeagueId(id);
    Modular.to.popAndPushNamed(EventRouter.create);
  }

  toEventCreation(String? id) {
    Session.instance.setLeagueId(id);
    Modular.to.pushNamed(EventRouter.create);
  }
}
