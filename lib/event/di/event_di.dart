import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/event/domain/fetch_events_use_case.dart';
import 'package:e_racing_app/event/event_view_model.dart';
import 'package:e_racing_app/event/presentation/ui/event_screen.dart';
import 'package:e_racing_app/media/get_media.usecase.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';


class EventModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => EventViewModel()),
        Bind.factory((i) => GetMediaUseCase<MediaModel>()),
        Bind.factory((i) => FetchEventsUseCase<EventModel>()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => GetSocialMediaUseCase())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const EventScreen()),
      ];
}
