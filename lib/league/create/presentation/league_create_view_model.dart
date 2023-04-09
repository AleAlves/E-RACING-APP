import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/create/domain/create_league_usecase.dart';
import 'package:e_racing_app/league/create/presentation/navigation/league_create_flow.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../home/domain/model/league_model.dart';

part 'league_create_view_model.g.dart';

class LeagueCreateViewModel = _LeagueCreateViewModel
    with _$LeagueCreateViewModel;

abstract class _LeagueCreateViewModel
    extends BaseViewModel<LeagueCreateNavigator> with Store {
  _LeagueCreateViewModel();

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<SocialPlatformModel?>? socialMedias = ObservableList();

  @override
  @observable
  LeagueCreateNavigator? flow;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  StatusModel? status;

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

  @observable
  double? maxSteps = 8;

  @observable
  double? currentStep;

  final createUseCase = Modular.get<CreateLeagueUseCase<StatusModel>>();
  final getTagUseCase = Modular.get<GetTagUseCase>();
  final getSocialMediaUseCase = Modular.get<GetSocialMediaUseCase>();

  Future<void> create() async {
    await createUseCase
        .build(
            league: LeagueModel(
                name: name,
                description: description,
                banner: banner,
                tags: leagueTags,
                links: socialPlatforms))
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
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
    onNavigate(LeagueCreateNavigator.review);
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
}
