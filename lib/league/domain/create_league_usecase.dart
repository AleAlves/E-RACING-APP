import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/league/data/league_create_model.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';
import 'package:e_racing_app/league/presentation/ui/navigation/league_flow.dart';

class CreateLeagueUseCase<T> extends BaseUseCase<T> {
  late LeagueModel _league;

  CreateLeagueUseCase<T> build({required LeagueModel league}) {
    _league = league;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(data: LeagueCreateModel(_league))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "League Created", action: "Ok", next: LeagueFlow.list) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
