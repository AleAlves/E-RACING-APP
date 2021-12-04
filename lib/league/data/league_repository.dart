
import 'package:e_racing_app/core/service/http_response.dart';

abstract class LeagueDataSource {

  Future getLeague(String email, String password, Function(HTTPResponse) success,
      Function(HTTPResponse) error);

}