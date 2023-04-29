import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/manage/presentation/router/event_manage_router.dart';

import '../../../core/model/pair_model.dart';

class CancelRaceUseCase<T> extends BaseUseCase<T> {
  late String? _raceId;

  CancelRaceUseCase<T> build({required String? raceId}) {
    _raceId = raceId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: 'api/v1/event/race/cancel',
        params: HTTPRequesParams(query: Pair("id", _raceId)),
        verb: HTTPVerb.put));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Race finished",
          action: "Ok",
          route: EventManageRouter.main) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
