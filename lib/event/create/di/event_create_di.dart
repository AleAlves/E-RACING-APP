import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/status_model.dart';
import '../../domain/create_event_usecase.dart';
import '../presentation/event_create_view_model.dart';
import '../presentation/navigation/event_create_flow.dart';
import '../presentation/ui/event_create_screen.dart';

class EventCreateModule extends Module {
  final EventCreateNavigator flow;

  EventCreateModule({this.flow = EventCreateNavigator.terms});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => EventCreateViewModel()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => CreateEventUseCase<StatusModel>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => EventCreateScreen(flow)),
      ];
}
