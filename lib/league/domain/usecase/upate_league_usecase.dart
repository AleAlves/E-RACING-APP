import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/data/model/league_create_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';

class UpdateLeagueUseCase<T> extends BaseUseCase<T?> {
  late MediaModel _media;
  late LeagueModel _league;

  UpdateLeagueUseCase<T> params(
      {required LeagueModel league, required MediaModel media}) {
    _media = media;
    _league = league;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league",
        verb: HTTPVerb.put,
        params: HTTPRequesParams(data: LeagueCreateModel(_media, _league))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "League Updated", action: "Ok", next: LeagueFlow.list) as T);
    } else {
      error.call();
    }
  }
}
