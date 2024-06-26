import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/league/LeagueRouter.dart';

import '../data/league_create_request.dart';
import 'model/league_create_model.dart';

class CreateLeagueUseCase<T> extends BaseUseCase<T> {
  late LeagueCreateModel _league;

  CreateLeagueUseCase<T> build({required LeagueCreateModel league}) {
    _league = league;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(data: LeagueCreateRequest(_league))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "League Created",
          action: "Ok",
          route: LeagueRouter.detail) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
