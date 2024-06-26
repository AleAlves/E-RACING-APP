import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/event_router.dart';

import '../../core/data/event_do_subscribe_model.dart';

class SubscribeEventUseCase<T> extends BaseUseCase<T> {
  late String? _classId;
  late String? _eventId;

  SubscribeEventUseCase<T> build(
      {required String? classId, required String? eventId}) {
    _classId = classId;
    _eventId = eventId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/subscribe",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: EventDoSubscribeCreateModel(
                classId: _classId ?? '', eventId: _eventId ?? ''))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Subscribed in the event, good luck!",
          action: "Ok",
          route: EventRouter.detail) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
