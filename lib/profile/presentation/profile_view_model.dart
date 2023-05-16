import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/profile/presentation/navigation/profile_navigation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/model/media_model.dart';
import '../../core/model/tag_model.dart';
import '../../login/legacy/domain/model/user_model.dart';
import '../../shared/media/get_media.usecase.dart';
import '../../shared/tag/get_tag_usecase.dart';
import '../domain/model/profile_model.dart';
import '../domain/update_profile_usecase.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModel with _$ProfileViewModel;

abstract class _ProfileViewModel extends BaseViewModel<ProfileNavigationSet>
    with Store {
  _ProfileViewModel();

  @override
  @observable
  ProfileNavigationSet? flow = ProfileNavigationSet.home;

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @override
  @observable
  ViewState state = ViewState.loading;

  @observable
  ProfileModel? profileModel;

  @observable
  MediaModel? picture;

  @override
  @observable
  StatusModel? status;

  @override
  String? title = "";

  final _getTagUseCase = Modular.get<GetTagUseCase>();
  final _profile = Modular.get<UpdateProfileUseCase<UserModel>>();
  final _getMediaUseCase = Modular.get<GetMediaUseCase<MediaModel?>>();

  fetchProfile() {
    profileModel = Session.instance.getUser()?.profile;
    state = ViewState.loading;
    fetchTags();
  }

  void fetchTags() async {
    await _getTagUseCase.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          _getMedia(Session.instance.getUser()?.id);
        },
        failure: onError);
  }

  void setPicture(String picture) {
    this.picture?.image = picture;
  }

  update(String name, String surName, String country, String picture) async {
    state = ViewState.loading;
    await _profile
        .params(
            name: name, surName: surName, country: country, picture: picture)
        .invoke(
            success: (data) {
              Session.instance.setUser(data);
              status = StatusModel(
                  message: "Profile updated",
                  action: "Ok",
                  route: ProfileNavigationSet.home);
              state = ViewState.ready;
              flow = ProfileNavigationSet.status;
            },
            failure: onError);
  }

  _getMedia(String? id) async {
    await _getMediaUseCase.params(id: id).invoke(
        success: (data) {
          picture = data;
          state = ViewState.ready;
        },
        failure: () {});
  }
}
