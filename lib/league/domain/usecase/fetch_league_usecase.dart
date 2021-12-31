import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';

class FetchLeagueUseCase<T> extends BaseUseCase {
  @override
  void invoke({required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/leagues",
        verb: HTTPVerb.get,
        params: HTTPRequesParams()));

    if (response.isSuccessfully) {
      success.call(response.data
          .map<LeagueModel>((league) => LeagueModel.fromJson(league))
          .toList());
    } else {
      error.call();
    }
  }
}
