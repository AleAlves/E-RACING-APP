import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../data/set_summary_model.dart';
import '../presentation/ui/event_flow.dart';

class SetSummaryUseCase<T> extends BaseUseCase<T> {
  late SetSummaryModel? _summaryModel;

  SetSummaryUseCase<T> build({SetSummaryModel? summaryModel}) {
    _summaryModel = summaryModel;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/result",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(data: _summaryModel)));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "",
          action: "",
          next: EventFlow.managementEditRaceResultsEdit) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
