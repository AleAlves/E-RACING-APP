import 'package:e_racing_app/core/service/api_service.dart';
import 'package:e_racing_app/core/service/base/base_service.dart';
import 'package:e_racing_app/core/data/http_request.dart';

import 'http_response.dart';

abstract class RemoteRepository {
  Future<HTTPResponse> call(Request request);
}

class RemoteRepositoryImpl extends RemoteRepository {
  final BaseService _service = ApiService();

  @override
  Future<HTTPResponse> call(Request request) async {
    return await _service.call(request);
  }
}
