import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/data/http_response.dart';

abstract class BaseService {

  final String server = "http://192.168.0.15:8084/";
  //final String server = "https://e-racing-api-dev.herokuapp.com/";

  Future<HTTPResponse> call(Request request);

}