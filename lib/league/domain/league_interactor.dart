import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/data/league_repository.dart';
import 'package:e_racing_app/league/data/model/league_create_model.dart';

abstract class LeagueInteractor {
  Future create(String name, String description, String banner64,
      Function() success, Function(ApiException) error);

  Future fetch(
      Function(List<LeagueModel>) success, Function(ApiException) error);
}

class LeagueInteractorImpl extends LeagueInteractor {
  final repository = LeagueRepositoryIml();

  @override
  Future create(String name, String description, String banner64,
      Function() success, Function(ApiException) error) async {
    var request = LeagueCreateModel(MediaModel(banner64),
        LeagueModel(name: name, description: description));
    await repository.create(request, (response) {
      success();
    }, (err) {
      error(ApiException("_message"));
    });
  }

  @override
  Future fetch(
      Function(List<LeagueModel>) success, Function(ApiException) error) async {
    await repository.fetch((response) {
      var items = (response.data as List)
          .map<LeagueModel>((_feed) => LeagueModel.fromJson(_feed))
          .toList();
      success(items);
    }, (err) {
      error(ApiException("_message"));
    });
  }
}
