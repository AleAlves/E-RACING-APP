import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/event_router.dart';

import '../../../core/model/pair_model.dart';

class FinishEventUseCase<T> extends BaseUseCase<T> {
  late String _id;

  FinishEventUseCase<T> build({required String id}) {
    _id = id;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/state/finish",
        params: HTTPRequesParams(query: Pair("id", _id)),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Event finished",
          action: "Ok",
          route: EventRouter.manage) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
