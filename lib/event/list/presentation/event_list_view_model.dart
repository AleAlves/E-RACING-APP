import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/event/list/presentation/router/event_list_router.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/event_model.dart';
import '../../../core/model/status_model.dart';
import '../../../core/model/tag_model.dart';
import '../../../core/ui/view_state.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../domain/fetch_events_use_case.dart';
import '../domain/search_event_use_case.dart';

part 'event_list_view_model.g.dart';

class EventListViewModel = _EventListViewModel with _$EventListViewModel;

abstract class _EventListViewModel extends BaseViewModel<EventListRouter>
    with Store {
  _EventListViewModel();

  @override
  @observable
  EventListRouter? flow;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  String? title = "";

  @override
  @observable
  StatusModel? status;

  @observable
  ObservableList<EventModel?>? events;

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  List<String>? searchTags = [];

  final _getTagUseCase = Modular.get<GetTagUseCase>();
  final _fetchEvents = Modular.get<FetchEventsUseCase<List<EventModel>>>();
  final _searchEvents = Modular.get<SearchEventsUseCase<List<EventModel>>>();

  fetchEvents() async {
    state = ViewState.loading;
    _fetchEvents.build(leagueId: Session.instance.getLeagueId()).invoke(
        success: (data) {
          events = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  searchEvents() async {
    state = ViewState.loading;
    _searchEvents.build(tagIds: searchTags).invoke(
        success: (data) {
          events = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  getTags() async {
    state = ViewState.loading;
    await _getTagUseCase.invoke(
        success: (data) {
          tags = ObservableList.of(data);
        },
        error: onError);
  }
}
