import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../../core/model/pair_model.dart';
import '../../LeagueRouter.dart';

class StopMembershipUseCase<T> extends BaseUseCase<T> {
  String? _leagueId;

  StopMembershipUseCase<T> build({required String? leagueId}) {
    _leagueId = leagueId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league/membership/stop",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: Pair("id", _leagueId))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "You're no longer a member",
          action: "Ok",
          route: LeagueRouter.detail) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
