
import 'package:e_racing_app/core/service/http_response.dart';

abstract class HomeDataSource {

  Future getHome(String email, String password, Function(HTTPResponse) success,
      Function(HTTPResponse) error);

}