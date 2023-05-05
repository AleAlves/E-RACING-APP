import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../../core/model/pair_model.dart';

class GetUserEventUseCase<T> extends BaseUseCase<T> {
  late String _leagueId;

  GetUserEventUseCase<T> params({required String leagueId}) {
    _leagueId = leagueId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/list/filter/user",
        params: HTTPRequesParams(query: Pair("id", _leagueId)),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      var list = response.data == null
          ? null
          : response.data
              .map<EventModel>((event) => EventModel.fromJson(event))
              .toList() as T;
      success.call(list as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
