import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../../../core/model/pair_model.dart';
import '../presentation/router/event_manage_router.dart';

class FinishRaceUseCase<T> extends BaseUseCase<T> {
  late String? _raceId;

  FinishRaceUseCase<T> build({required String? raceId}) {
    _raceId = raceId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: 'api/v1/event/race/finish',
        params: HTTPRequesParams(query: Pair("id", _raceId)),
        verb: HTTPVerb.put));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Race finished",
          action: "Ok",
          route: EventManageRouter.main) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
