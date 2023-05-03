import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/profile/data/profile_model.dart';
import 'package:e_racing_app/profile/presentation/navigation/profile_navigation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/model/tag_model.dart';
import '../../login/legacy/domain/model/user_model.dart';
import '../../shared/tag/get_tag_usecase.dart';
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

  @override
  @observable
  StatusModel? status;

  @override
  String? title = "";

  final _getTagUseCase = Modular.get<GetTagUseCase>();
  final profile = Modular.get<UpdateProfileUseCase<UserModel>>();

  fetchProfile() {
    profileModel = Session.instance.getUser()?.profile;
    state = ViewState.loading;
    fetchTags();
  }

  void fetchTags() async {
    await _getTagUseCase.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  update(String name, String surname, String country) async {
    state = ViewState.loading;
    await profile.params(name: name, surname: surname, country: country).invoke(
        success: (data) {
          Session.instance.setUser(data);
          status = StatusModel(
              message: "Profile updated",
              action: "Ok",
              route: ProfileNavigationSet.home);
          state = ViewState.ready;
          flow = ProfileNavigationSet.status;
        },
        error: onError);
  }

  void retry() {
    state = ViewState.ready;
  }
}
