import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/data/http_response.dart';

abstract class BaseService {

  Future<HTTPResponse> call(Request request);

}