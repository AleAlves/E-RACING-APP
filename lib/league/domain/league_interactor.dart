import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/data/league_repository.dart';
import 'package:e_racing_app/league/data/model/league_create_model.dart';

abstract class LeagueInteractor {
  Future create(
      String name,
      String description,
      String banner,
      String emblem,
      List<String?> tags,
      List<LinkModel?> links,
      Function() success,
      Function(ApiException) error);

  Future update(MediaModel media, LeagueModel league, Function() success,
      Function(ApiException) error);

  Future fetch(
      Function(List<LeagueModel>) success, Function(ApiException) error);

  Future<LeagueModel> get(String id);
}

class LeagueInteractorImpl extends LeagueInteractor {
  final _repository = LeagueRepositoryIml();

  @override
  Future create(
      String name,
      String description,
      String banner,
      String emblem,
      List<String?> tags,
      List<LinkModel?> links,
      Function() success,
      Function(ApiException) error) async {
    var request = LeagueCreateModel(
        MediaModel(banner),
        LeagueModel(
            name: name,
            description: description,
            tags: tags,
            emblem: emblem,
            links: links));
    await _repository.create(request, (response) {
      success();
    }, (err) {
      error(ApiException("_message"));
    });
  }

  @override
  Future fetch(
      Function(List<LeagueModel>) success, Function(ApiException) error) async {
    await _repository.fetch((response) {
      var items = (response.data as List)
          .map<LeagueModel>((_feed) => LeagueModel.fromJson(_feed))
          .toList();
      success(items);
    }, (err) {
      error(ApiException("_message"));
    });
  }

  @override
  Future update(MediaModel media, LeagueModel league, Function() success,
      Function(ApiException) error) async {
    return await _repository.update(LeagueCreateModel(media, league));
  }

  @override
  Future<LeagueModel> get(String id) async {
    return LeagueModel.fromJson((await _repository.get(id)).data);
  }
}
