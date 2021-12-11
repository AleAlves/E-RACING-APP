import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';

abstract class BaseService {

  final String server = "http://192.168.0.15:8084/";

  Future call(HTTPRequest request, Function(HTTPResponse) success, Function(HTTPResponse) error);

  Future<HTTPResponse> call2(HTTPRequest request);

}