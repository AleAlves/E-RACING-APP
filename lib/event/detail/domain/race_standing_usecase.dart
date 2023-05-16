import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../../core/model/pair_model.dart';
import '../../core/data/race_standings_model.dart';

class RaceStandingsUseCase<T> extends BaseUseCase<T> {
  late String _id;

  RaceStandingsUseCase<T> build({required String id}) {
    _id = id;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/race/standings",
        params: HTTPRequesParams(query: Pair("id", _id)),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      success.call(RaceStandingsModel.fromJson(response.data) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
