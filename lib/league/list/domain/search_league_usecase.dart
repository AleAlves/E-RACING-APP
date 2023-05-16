import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../core/league_model.dart';
import '../data/league_search_request.dart';

class SearchLeagueUseCase<T> extends BaseUseCase<T?> {
  late List<String>? _tagIds;

  SearchLeagueUseCase<T> build({required List<String>? tagIds}) {
    _tagIds = tagIds;
    return this;
  }

  @override
  void invoke(
      {required Function(T?) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league/search",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(data: LeagueSearchRequest(_tagIds))));
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
