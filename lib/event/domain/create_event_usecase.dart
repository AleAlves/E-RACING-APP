import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/event/data/event_create_model.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';

class CreateEventUseCase<T> extends BaseUseCase<T> {
  late MediaModel? _media;
  late EventModel _event;

  CreateEventUseCase<T> build(
      {required EventModel event, MediaModel? media}) {
    _media = media;
    _event = event;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(data: EventCreateModel(_media, _event))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Event Created", action: "Ok", next: EventFlows.list) as T);
    } else {
      error.call();
    }
  }
}
