import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/use_case_response.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/data/league_repository.dart';
import 'package:e_racing_app/media/media_repository.dart';

class FetchLeagueUseCase {
  final LeagueRepository _repository = LeagueRepositoryIml();

  Future<UseCaseResponse> invoke() async {
    var response = await _repository.fetch();
    var code = response?.response?.code;
    return UseCaseResponse<List<LeagueModel>>(
        code == 200 || code == 201 || code == 202 || code == 203 || code == 204,
        response?.data
            .map<LeagueModel>((league) => LeagueModel.fromJson(league))
            .toList());
  }
}
