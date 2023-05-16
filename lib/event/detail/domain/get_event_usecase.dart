import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../../core/model/pair_model.dart';
import '../../core/data/event_home_model.dart';

class GetEventUseCase<T> extends BaseUseCase<T> {
  late String? _eventId;

  GetEventUseCase<T> params({required String? eventId}) {
    _eventId = eventId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/home",
        params: HTTPRequesParams(query: Pair("id", _eventId)),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      success.call(response.data == null
          ? null
          : EventHomeModel.fromJson(response.data) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
