import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/status_model.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../domain/create_event_usecase.dart';
import '../presentation/event_create_view_model.dart';
import '../presentation/navigation/event_create_flow.dart';
import '../presentation/ui/event_create_screen.dart';

class EventCreateModule extends Module {
  final EventCreateNavigator flow;

  EventCreateModule({this.flow = EventCreateNavigator.eventTerms});

  @override
  void binds(i) {
    i.add<EventCreateViewModel>(EventCreateViewModel.new);
    i.add<GetTagUseCase<dynamic>>(GetTagUseCase<dynamic>.new);
    i.add<CreateEventUseCase<StatusModel>>(CreateEventUseCase<StatusModel>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => EventCreateScreen(flow));
  }
}
