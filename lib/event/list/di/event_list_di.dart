import 'package:e_racing_app/event/list/presentation/router/event_list_router.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/event_model.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../domain/fetch_events_use_case.dart';
import '../domain/search_event_use_case.dart';
import '../presentation/event_list_screen.dart';
import '../presentation/event_list_view_model.dart';

class EventListModule extends Module {
  final EventListRouter router;

  EventListModule({this.router = EventListRouter.search});

  @override
  void binds(i) {
    i.add<EventListViewModel>(EventListViewModel.new);
    i.add<GetTagUseCase>(GetTagUseCase.new);
    i.add<FetchEventsUseCase<List<EventModel>>>(FetchEventsUseCase.new);
    i.add<SearchEventsUseCase<List<EventModel>>>(SearchEventsUseCase.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => EventListScreen(router: router));
  }
}
