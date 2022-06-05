import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/data/remove_subscription_model.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';

class RemoveSubscriptionUseCase<T> extends BaseUseCase<T> {
  late String? _classId;
  late String? _eventId;
  late String? _userId;

  RemoveSubscriptionUseCase<T> build(
      {required String? classId, required String? eventId, required String? userId}) {
    _classId = classId;
    _eventId = eventId;
    _userId = userId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/remove/subscription",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: RemoveSubscriptionModel(
                classId: _classId ?? '',
                eventId: _eventId ?? '',
                userId: _userId ?? ''))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Subscription removed from the event",
          action: "Ok",
          next: EventFlow.manager) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
