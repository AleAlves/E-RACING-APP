import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

class FetchEventsUseCase<T> extends BaseUseCase<T> {
  late String? _leagueId;

  FetchEventsUseCase<T> build({required String? leagueId}) {
    _leagueId = leagueId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/list",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: Pair("id", _leagueId))));
    if (response.isSuccessfully) {
      var list = response.data == null
          ? null
          : response.data
              .map<EventModel>((event) => EventModel.fromJson(event))
              .toList() as T;
      success.call(list as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
