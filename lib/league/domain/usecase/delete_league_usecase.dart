import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';

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
      success.call(StatusModel(
          message: "League Deleted", action: "Ok", next: LeagueFlow.list) as T);
    } else {
      error.call();
    }
  }
}
