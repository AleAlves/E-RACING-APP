import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/http_request.dart';

class DeleteLeagueUseCase<T> extends BaseUseCase {
  @override
  void invoke({required Function(T) success, required Function error}) {
    // TODO: implement invoke
  }
  // Future<UseCaseResponse> invoke(String id) async {
  //   var request = Request(
  //       endpoint: "api/v1/league",
  //       verb: HTTPVerb.delete,
  //       params: HTTPRequesParams(query: id));
  //   var response = await super.call(request);
  //   return UseCaseResponse(response.response?.code, response.data);
  // }
}
