import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/event_router.dart';

import '../../../core/data/set_summary_model.dart';


class SetSummaryUseCase<T> extends BaseUseCase<T> {
  late SetSummaryModel? _summaryModel;

  SetSummaryUseCase<T> build({SetSummaryModel? summaryModel}) {
    _summaryModel = summaryModel;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/result",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(data: _summaryModel)));
    if (response.isSuccessfully) {
      success.call(
          StatusModel(message: "", action: "", route: EventRouter.manage) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
