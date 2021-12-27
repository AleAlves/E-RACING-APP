import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/use_case_response.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/data/league_repository.dart';
import 'package:e_racing_app/league/data/model/league_create_model.dart';
import 'package:e_racing_app/media/media_repository.dart';

class UpdateLeagueUseCase {
  final LeagueRepository _repository = LeagueRepositoryIml();

  Future<UseCaseResponse> invoke(LeagueModel league, MediaModel media) async {
    var request = LeagueCreateModel(media, league);
    var response = await _repository.update(request);
    var code = response?.response?.code;
    return UseCaseResponse(
        code == 200 || code == 201 || code == 202 || code == 203 || code == 204,
        response?.data);
  }
}
