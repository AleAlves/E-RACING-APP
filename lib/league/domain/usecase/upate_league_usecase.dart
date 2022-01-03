import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/data/model/league_create_model.dart';

class UpdateLeagueUseCase<T> extends BaseUseCase<T?> {
  final MediaModel media;
  final LeagueModel league;

  UpdateLeagueUseCase({required this.league, required this.media});

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league",
        verb: HTTPVerb.put,
        params: HTTPRequesParams(data: LeagueCreateModel(media, league))));
    if (response.isSuccessfully) {
      success.call(true as T);
    } else {
      error.call();
    }
  }
}
