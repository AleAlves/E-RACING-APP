import 'package:e_racing_app/core/service/api_service.dart';
import 'package:e_racing_app/core/service/base/base_service.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';

abstract class SocialMediaRepository {
  Future<HTTPResponse> get();
}

class SocialMediaRepositoryImpl extends SocialMediaRepository {
  final BaseService _service = ApiService();

  @override
  Future<HTTPResponse> get() {
    return _service.call2(HTTPRequest(endpoint: "api/v1/social-platforms", verb: HTTPVerb.get));
  }
}
