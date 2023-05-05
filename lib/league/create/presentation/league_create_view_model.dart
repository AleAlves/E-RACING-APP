import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/create/domain/create_league_usecase.dart';
import 'package:e_racing_app/league/create/presentation/navigation/league_create_flow.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/social/get_social_media_usecase.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../domain/model/league_create_model.dart';

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
  String? title = "";

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
  List<LinkModel?>? linkModels;

  @observable
  int maxSteps = 7;

  @observable
  int currentStep = 1;

  final _createUseCase = Modular.get<CreateLeagueUseCase<StatusModel>>();
  final _getTagUseCase = Modular.get<GetTagUseCase>();
  final getSocialMediaUseCase = Modular.get<GetSocialMediaUseCase>();

  void fetchTerms() {}

  increaseStep() {
    currentStep++;
  }

  decreaseStep() {
    currentStep--;
  }

  void setAgreement(bool termsAgreement) {
    this.termsAgreement = termsAgreement;
    onRoute(LeagueCreateNavigator.name);
  }

  void setName(String name) {
    this.name = name;
    onRoute(LeagueCreateNavigator.description);
  }

  void setDescription(String description) {
    this.description = description;
    onRoute(LeagueCreateNavigator.banner);
  }

  void setBanner(String banner) {
    this.banner = banner;
  }

  void setTags(List<String?>? leagueTags) {
    this.leagueTags = leagueTags;
  }

  void setSocialMedia(List<LinkModel?> linkModels) {
    this.linkModels = linkModels;
    onRoute(LeagueCreateNavigator.review);
  }

  void fetchTags() async {
    state = ViewState.loading;
    await _getTagUseCase.invoke(
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

  Future<void> create() async {
    state = ViewState.loading;
    await _createUseCase
        .build(
            league: LeagueCreateModel(
                name: name,
                description: description,
                banner: banner,
                tags: leagueTags,
                links: linkModels))
        .invoke(
            success: (data) {
              status = data;
              onRoute(LeagueCreateNavigator.status);
              state = ViewState.ready;
            },
            error: onError);
  }
}
