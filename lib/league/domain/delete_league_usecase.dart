import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/league/presentation/ui/navigation/league_flow.dart';

class DeleteLeagueUseCase<T> extends BaseUseCase {
  late String _id;

  DeleteLeagueUseCase<T> params({required String id}) {
    _id = id;
    return this;
  }

  @override
  void invoke({required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league",
        verb: HTTPVerb.delete,
        params: HTTPRequesParams(query: _id)));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "League Deleted", action: "Ok", next: LeagueFlow.list) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
