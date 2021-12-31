import 'package:e_racing_app/core/domain/base_usecase.dart';

class CreateLeagueUseCase<T> extends BaseUseCase<T> {
  @override
  void invoke({required Function(T) success, required Function error}) {
    // var request = Request(
    //     endpoint: "api/v1/league",
    //     verb: HTTPVerb.post,
    //     params: HTTPRequesParams(data: LeagueCreateModel(media, league)));
    // var response = await super.call(request);
    // success( UseCaseResponse(response.response?.code, response.data));
  }

}
