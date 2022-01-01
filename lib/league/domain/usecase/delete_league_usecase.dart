import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/http_request.dart';

class DeleteLeagueUseCase<T> extends BaseUseCase {
  final String id;

  DeleteLeagueUseCase({required this.id});

  @override
  void invoke({required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league",
        verb: HTTPVerb.delete,
        params: HTTPRequesParams(query: id)));
    if (response.isSuccessfully) {
      success.call(response.data);
    } else {
      error.call();
    }
  }
}
