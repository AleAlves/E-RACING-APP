import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/data/model/league_create_model.dart';

class UpdateLeagueUseCase<T> extends BaseUseCase<T> {
  @override
  void invoke({required Function(T) success, required Function error}) {
    // TODO: implement invoke
  }
  // Future<UseCaseResponse> invoke(LeagueModel league, MediaModel media) async {
  //   var request = Request(
  //       endpoint: "api/v1/league",
  //       verb: HTTPVerb.put,
  //       params: HTTPRequesParams(data: LeagueCreateModel(media, league)));
  //   var response = await super.call(request);
  //   return UseCaseResponse(response.response?.code, response.data);
  // }
}
