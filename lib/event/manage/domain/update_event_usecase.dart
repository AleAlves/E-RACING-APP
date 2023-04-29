import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../core/data/event_create_model.dart';
import '../../event_router.dart';

class UpdateEventUseCase<T> extends BaseUseCase<T> {
  late MediaModel? _media;
  late EventModel? _event;
  late String? _leagueId;

  UpdateEventUseCase<T> build(
      {required EventModel? event, MediaModel? media, String? leagueId}) {
    _media = media;
    _event = event;
    _leagueId = leagueId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event",
        verb: HTTPVerb.put,
        params: HTTPRequesParams(
            data: EventCreateModel(_media, _event, _leagueId))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Event Updated",
          action: "Ok",
          route: EventRouter.manage) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
