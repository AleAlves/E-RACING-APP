import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/data/event_do_subscribe_model.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';

class UnsubscribeEventUseCase<T> extends BaseUseCase<T> {
  late String? _classId;
  late String? _eventId;

  UnsubscribeEventUseCase<T> build(
      {required String? classId, required String? eventId}) {
    _classId = classId;
    _eventId = eventId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/unsubscribe",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: EventDoSubscribeCreateModel(
                classId: _classId ?? '', eventId: _eventId ?? ''))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "You've been removed from this event", action: "Ok", next: EventFlow.eventDetail) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
