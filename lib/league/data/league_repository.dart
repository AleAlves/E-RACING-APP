import 'package:e_racing_app/core/service/api_service.dart';
import 'package:e_racing_app/core/service/base/base_service.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';

import 'model/league_create_model.dart';

abstract class LeagueRepository {
  Future fetch(Function(HTTPResponse) success, Function(HTTPResponse) error);

  Future create(LeagueCreateModel request, Function(HTTPResponse) success,
      Function(HTTPResponse) error);
}

class LeagueRepositoryIml extends LeagueRepository {
  final BaseService _service = ApiService();

  @override
  Future fetch(
      Function(HTTPResponse) success, Function(HTTPResponse) error) async {
    await _service.call(
        HTTPRequest(
            endpoint: "api/v1/league",
            verb: HTTPVerb.get,
            params: HTTPRequesParams()),
        success,
        error);
  }

  @override
  Future create(LeagueCreateModel request, Function(HTTPResponse p1) success,
      Function(HTTPResponse) error) async {
    await _service.call(
        HTTPRequest(
            endpoint: "api/v1/league",
            verb: HTTPVerb.post,
            params: HTTPRequesParams(data: request)),
        success,
        error);
  }
}
