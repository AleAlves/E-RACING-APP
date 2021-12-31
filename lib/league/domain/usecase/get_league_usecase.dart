import 'package:e_racing_app/core/domain/base_usecase.dart';

class GetLeagueUseCase<T> extends BaseUseCase<T> {
  @override
  void invoke({required Function(T) success, required Function error}) {
    // TODO: implement invoke
  }
// Future<UseCaseResponse> invoke(String id) async {
//   var request = Request(
//       endpoint: "api/v1/league",
//       verb: HTTPVerb.get,
//       params: HTTPRequesParams(query: id));
//
//   var response = await super.call(request);
//
//   return UseCaseResponse(response.response?.code, response.data);
// }
}
