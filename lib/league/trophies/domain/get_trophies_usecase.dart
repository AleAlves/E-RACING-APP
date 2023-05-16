import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/league/trophies/domain/model/podium_model.dart';

import '../../../core/model/pair_model.dart';

class GetTrophiesUseCase<T> extends BaseUseCase<T> {
  late String _leagueId;

  GetTrophiesUseCase<T> build({required String leagueId}) {
    _leagueId = leagueId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league/trophy/list",
        params: HTTPRequesParams(query: Pair("id", _leagueId)),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      var list = response.data == null
          ? null
          : response.data
              .map<PodiumModel>((league) => PodiumModel.fromJson(league))
              .toList() as T;
      success.call(list);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
