import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/league/list/domain/search_league_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/model/tag_model.dart';
import '../../../core/ui/view_state.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../../core/league_model.dart';
import '../domain/fetch_league_usecase.dart';
import 'navigation/league_list_navigation.dart';

part 'league_list_view_model.g.dart';

class LeagueListViewModel = _LeagueListViewModel with _$LeagueListViewModel;

abstract class _LeagueListViewModel
    extends BaseViewModel<LeagueListNavigationSet> with Store {
  _LeagueListViewModel();

  @override
  @observable
  LeagueListNavigationSet? flow = LeagueListNavigationSet.main;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "Leagues";

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

  fetchLeagues() async {
    state = ViewState.loading;
    _fetchListUC.invoke(
        success: (data) {
          leagues = ObservableList.of(data!);
          _fetchTags();
        },
        error: onError);
  }

  searchEvents() async {
    state = ViewState.loading;
    _searchListUC.build(tagIds: searchTags).invoke(
        success: (data) {
          leagues = ObservableList.of(data!);
          state = ViewState.ready;
        },
        error: onError);
  }

  _fetchTags() async {
    state = ViewState.loading;
    await _fetchTagsUC.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  void getUser() async {
    state = ViewState.loading;
  }
}
