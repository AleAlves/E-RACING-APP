import 'package:e_racing_app/core/service/api_service.dart';
import 'package:e_racing_app/core/service/base/base_service.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';

import 'model/league_create_model.dart';

abstract class LeagueRepository {

  Future<HTTPResponse?> fetch();

  Future<HTTPResponse?> get(String id);

  Future<HTTPResponse?> delete(String id);

  Future<HTTPResponse?> create(LeagueCreateModel request);

  Future<HTTPResponse?> update(LeagueCreateModel request);
}

class LeagueRepositoryIml extends LeagueRepository {
  final BaseService _service = ApiService();

  @override
  Future<HTTPResponse?> fetch() async {
    return await _service.callAsync(HTTPRequest(
        endpoint: "api/v1/leagues",
        verb: HTTPVerb.get,
        params: HTTPRequesParams()));
  }

  @override
  Future<HTTPResponse?> get(String id) async {
    return await _service.callAsync(HTTPRequest(
        endpoint: "api/v1/league",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: id)));
  }

  @override
  Future<HTTPResponse?> create(LeagueCreateModel request) async {
    return await _service.callAsync(HTTPRequest(
        endpoint: "api/v1/league",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(data: request)));
  }

  @override
  Future<HTTPResponse?> update(LeagueCreateModel request) async {
    return await _service.callAsync(HTTPRequest(
        endpoint: "api/v1/league",
        verb: HTTPVerb.put,
        params: HTTPRequesParams(data: request)));
  }

  @override
  Future<HTTPResponse?> delete(String id) async {
    return await _service.callAsync(HTTPRequest(
        endpoint: "api/v1/league",
        verb: HTTPVerb.delete,
        params: HTTPRequesParams(query: id)));
  }
}
