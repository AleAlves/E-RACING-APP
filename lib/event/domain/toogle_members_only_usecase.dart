import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';

import '../../core/model/pair_model.dart';

class ToogleMembersOnlyUseCase<T> extends BaseUseCase<T> {
  late String? _eventId;

  ToogleMembersOnlyUseCase<T> build({
    required String? eventId,
  }) {
    _eventId = eventId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/members-only/toogle",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: Pair("id", _eventId))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Event membership option updated",
          action: "Ok",
          next: EventFlow.manager) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
