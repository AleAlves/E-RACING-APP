import 'http_request.dart';
import 'http_response.dart';

abstract class HTTPCall {
  late Request request;
  late Response response;
}