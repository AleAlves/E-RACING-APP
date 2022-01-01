import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/data/model/league_create_model.dart';

class CreateLeagueUseCase<T> extends BaseUseCase<T> {
  final MediaModel media;
  final LeagueModel league;

  CreateLeagueUseCase({required this.league, required this.media});

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(data: LeagueCreateModel(media, league))));
    if (response.isSuccessfully) {
      success.call(response.data);
    } else {
      error.call();
    }
  }
}
