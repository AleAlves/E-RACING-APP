import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../../../core/model/pair_model.dart';
import '../presentation/router/event_manage_router.dart';

class ToogleSubscriptionsUseCase<T> extends BaseUseCase<T> {
  late String? _eventId;

  ToogleSubscriptionsUseCase<T> build({
    required String? eventId,
  }) {
    _eventId = eventId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/subscriptions/toogle",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: Pair("id", _eventId))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Event subscriptions updated",
          action: "Ok",
          route: EventManageRouter.main) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
