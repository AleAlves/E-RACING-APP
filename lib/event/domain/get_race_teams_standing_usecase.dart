import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/data/event_teams_standings_model.dart';

class GetRaceTeamsStandingsUseCase<T> extends BaseUseCase<T> {
  late String _id;

  GetRaceTeamsStandingsUseCase<T> build({required String id}) {
    _id = id;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/teams/standings",
        params: HTTPRequesParams(query: _id),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      success.call(EventTeamsStandingsModel.fromJson(response.data) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
