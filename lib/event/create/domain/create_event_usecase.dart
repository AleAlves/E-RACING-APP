import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/create/data/event_create_request.dart';
import 'package:e_racing_app/event/event_router.dart';

import '../../core/data/event_create_model.dart';

class CreateEventUseCase<T> extends BaseUseCase<T> {
  late MediaModel? _media;
  late EventCreateModel _event;
  late String? _leagueId;

  CreateEventUseCase<T> build(
      {required EventCreateModel event,
      required String? leagueId,
      MediaModel? media,
      List<MediaModel?>? racePosters}) {
    _media = media;
    _event = event;
    _leagueId = leagueId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: EventCreateRequest(_leagueId, _event, _media))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Event Created",
          action: "Ok",
          route: EventRouter.list) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
