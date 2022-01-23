import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/data/http_request.dart';

class FetchEventsUseCase<T> extends BaseUseCase<T> {

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/events",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(safe: false)));
    if (response.isSuccessfully) {
      success(EventModel.fromJson(response.data) as T);
    } else {
      error.call();
    }
  }
}
