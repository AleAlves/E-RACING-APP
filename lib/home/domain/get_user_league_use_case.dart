import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../league/core/league_model.dart';

class GetUserLeagueUseCase<T> extends BaseUseCase<T?> {
  @override
  void invoke(
      {required Function(T?) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league/list/filter/user", verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      var list = response.data == null
          ? null
          : response.data
              .map<LeagueModel>((league) => LeagueModel.fromJson(league))
              .toList() as T;
      success.call(list);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
