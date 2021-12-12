import 'package:e_racing_app/core/service/api_service.dart';
import 'package:e_racing_app/core/service/base/base_service.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';

abstract class MediaRepository {
  Future<HTTPResponse> get(String id);
}

class MediaRepositoryImpl extends MediaRepository {
  final BaseService _service = ApiService();

  @override
  Future<HTTPResponse> get(String id) {
    return _service.call2(HTTPRequest(
        endpoint: "api/v1/media",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: id)));
  }
}
