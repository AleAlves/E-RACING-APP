import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/league/LeagueRouter.dart';
import 'package:e_racing_app/league/update/data/league_update_request.dart';

import '../../list/data/league_model.dart';

class UpdateLeagueUseCase<T> extends BaseUseCase<T?> {
  late MediaModel _media;
  late LeagueModel _league;

  UpdateLeagueUseCase<T> params(
      {required LeagueModel league, required MediaModel media}) {
    _media = media;
    _league = league;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league",
        verb: HTTPVerb.put,
        params: HTTPRequesParams(data: LeagueUpdateRequest(_league, _media))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "League Updated",
          action: "Ok",
          route: LeagueRouter.detail) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
