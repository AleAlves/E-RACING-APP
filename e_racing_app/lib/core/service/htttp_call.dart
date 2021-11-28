import 'http_request.dart';
import 'http_response.dart';

abstract class HTTPCall {
  late HTTPRequest request;
  late HTTPResponse response;
}