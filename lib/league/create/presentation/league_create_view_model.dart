import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/create/presentation/navigation/league_create_flow.dart';
import 'package:e_racing_app/league/domain/create_league_usecase.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'league_create_view_model.g.dart';

class LeagueCreateViewModel = _LeagueCreateViewModel
    with _$LeagueCreateViewModel;

abstract class _LeagueCreateViewModel
    extends BaseViewModel<LeagueCreateNavigator> with Store {
  _LeagueCreateViewModel();

  @observable
  LeagueCreateNavigator flow = LeagueCreateNavigator.terms;

  @observable
  StatusModel? status;

  @observable
  ViewState state = ViewState.ready;

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<SocialPlatformModel?>? socialMedias = ObservableList();

  @observable
  String? name;

  @observable
  String? description;

  @observable
  String? banner;

  @observable
  bool? termsAgreement;

  @observable
  List<String?>? leagueTags;

  @observable
  List<LinkModel?>? socialPlatforms;

  final createUseCase = Modular.get<CreateLeagueUseCase<StatusModel>>();
  final getTagUseCase = Modular.get<GetTagUseCase>();
  final getSocialMediaUseCase = Modular.get<GetSocialMediaUseCase>();

  Future<void> create(String name, String description, String banner,
      String emblem, List<String?> tags, List<LinkModel?> links) async {
    state = ViewState.loading;
    await createUseCase
        .build(
            league: LeagueModel(
                name: name,
                description: description,
                banner: emblem,
                tags: tags,
                links: links),
            media: MediaModel(banner))
        .invoke(
            success: (data) {
              status = data;
            },
            error: onError);
  }

  void fetchTerms() {}

  void setAgreement(bool termsAgreement) {
    this.termsAgreement = termsAgreement;
    onNavigate(LeagueCreateNavigator.name);
  }

  void setName(String name) {
    this.name = name;
    onNavigate(LeagueCreateNavigator.description);
  }

  void setDescription(String description) {
    this.description = description;
    onNavigate(LeagueCreateNavigator.banner);
  }

  void setBanner(String banner) {
    this.banner = banner;
    onNavigate(LeagueCreateNavigator.tags);
  }

  void setTags(List<String?> leagueTags) {
    this.leagueTags = leagueTags;
    onNavigate(LeagueCreateNavigator.socialMedia);
  }

  void setSocialMedia(List<LinkModel?> socialPlatforms) {
    this.socialPlatforms = socialPlatforms;
    onNavigate(LeagueCreateNavigator.finish);
  }

  void fetchTags() async {
    state = ViewState.loading;
    await getTagUseCase.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  void fetchSocialMedias() async {
    state = ViewState.loading;
    await getSocialMediaUseCase.invoke(
        success: (data) {
          socialMedias = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  @override
  void onError(LeagueCreateNavigator route) {
    status = StatusModel(
      message: "Something went wrong",
      action: "Ok",
      next: route.name,
      previous: route.name,
    );
    state = ViewState.ready;
  }

  @override
  void onNavigate(LeagueCreateNavigator route) {
    flow = route;
  }
}
