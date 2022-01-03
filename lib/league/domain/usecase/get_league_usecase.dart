import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';

class GetLeagueUseCase<T> extends BaseUseCase<T> {
  final String id;

  GetLeagueUseCase({required this.id});

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league",
        params: HTTPRequesParams(query: id),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      success.call(response.data == null
          ? null
          : LeagueModel.fromJson(response.data) as T);
    } else {
      error.call();
    }
  }
}
