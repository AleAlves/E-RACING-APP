import 'package:e_racing_app/event/list/presentation/router/event_list_router.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/event_model.dart';
import '../domain/fetch_events_use_case.dart';
import '../presentation/event_list_screen.dart';
import '../presentation/event_list_view_model.dart';

class EventListModule extends Module {
  final EventListRouter router;

  EventListModule({this.router = EventListRouter.main});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => EventListViewModel()),
        Bind.factory((i) => FetchEventsUseCase<List<EventModel>>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const EventListScreen()),
      ];
}