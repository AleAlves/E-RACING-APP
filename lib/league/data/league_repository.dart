import 'package:e_racing_app/core/service/api_service.dart';
import 'package:e_racing_app/core/service/base/base_service.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';

import 'model/league_create_model.dart';

abstract class LeagueRepository {
  Future fetch(Function(HTTPResponse) success, Function(HTTPResponse) error);

  Future create(LeagueCreateModel request, Function(HTTPResponse) success,
      Function(HTTPResponse) error);

  Future get(String id);

  Future update(LeagueCreateModel request);
}

class LeagueRepositoryIml extends LeagueRepository {
  final BaseService _service = ApiService();

  @override
  Future fetch(
      Function(HTTPResponse) success, Function(HTTPResponse) error) async {
    await _service.call(
        HTTPRequest(
            endpoint: "api/v1/leagues",
            verb: HTTPVerb.get,
            params: HTTPRequesParams()),
        success,
        error);
  }

  @override
  Future create(LeagueCreateModel request, Function(HTTPResponse) success,
      Function(HTTPResponse) error) async {
    await _service.call(
        HTTPRequest(
            endpoint: "api/v1/league",
            verb: HTTPVerb.post,
            params: HTTPRequesParams(data: request)),
        success,
        error);
  }

  @override
  Future update(LeagueCreateModel request) async {
    return await _service.callAsync(HTTPRequest(
        endpoint: "api/v1/league",
        verb: HTTPVerb.put,
        params: HTTPRequesParams(data: request)));
  }

  @override
  Future get(String id) async {
    return await _service.callAsync(HTTPRequest(
        endpoint: "api/v1/league",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: id)));
  }
}
