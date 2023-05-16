import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/league/LeagueRouter.dart';

import '../../../core/model/pair_model.dart';

class StartMembershipUseCase<T> extends BaseUseCase<T> {
  late String? _leagueId;

  StartMembershipUseCase<T> build({required String? leagueId}) {
    _leagueId = leagueId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league/membership/start",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: Pair("id", _leagueId))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "You've became a member",
          action: "Ok",
          route: LeagueRouter.detail) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
