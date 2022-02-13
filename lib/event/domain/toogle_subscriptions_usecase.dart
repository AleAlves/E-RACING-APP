import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/data/event_create_model.dart';
import 'package:e_racing_app/event/data/team_create_model.dart';
import 'package:e_racing_app/event/data/team_request_model.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';

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
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/subscriptions/toogle",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: _eventId)));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Subscriptions Updated",
          action: "Ok",
          next: EventFlows.detail) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
