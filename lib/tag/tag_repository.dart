import 'package:e_racing_app/core/service/api_service.dart';
import 'package:e_racing_app/core/service/base/base_service.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';

abstract class TagRepository {
  Future<HTTPResponse> get();
}

class TagRepositoryImpl extends TagRepository {
  final BaseService _service = ApiService();

  @override
  Future<HTTPResponse> get() {
    return _service
        .callAsync(HTTPRequest(endpoint: "api/v1/tags", verb: HTTPVerb.get));
  }
}
