import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/use_case_response.dart';
import 'package:e_racing_app/league/data/league_repository.dart';
import 'package:e_racing_app/media/media_repository.dart';

class DeleteLeagueUseCase {
  final LeagueRepository _repository = LeagueRepositoryIml();

  Future<UseCaseResponse> invoke(String id) async {
    var response = await _repository.delete(id);
    var code = response?.response?.code;
    return UseCaseResponse(
        code == 200 || code == 201 || code == 202 || code == 203 || code == 204,
        response?.data);
  }
}
