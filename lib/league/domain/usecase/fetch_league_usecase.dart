import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';

class FetchLeagueUseCase<T> extends BaseUseCase<T?> {
  @override
  void invoke({required Function(T?) success, required Function error}) async {
    var response = await super
        .remote(Request(endpoint: "api/v1/leagues", verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      var list = response.data == null
          ? null
          : response.data
              .map<LeagueModel>((league) => LeagueModel.fromJson(league))
              .toList() as T;
      success.call(list);
    } else {
      error.call();
    }
  }
}
