import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/profile/data/profile_model.dart';
import 'package:e_racing_app/profile/presentation/navigation/profile_navigation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../login/legacy/domain/model/user_model.dart';
import '../domain/update_profile_usecase.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModel with _$ProfileViewModel;

abstract class _ProfileViewModel extends BaseViewModel<ProfileNavigationSet>
    with Store {
  _ProfileViewModel();

  @override
  @observable
  ProfileNavigationSet? flow = ProfileNavigationSet.home;

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

  final profile = Modular.get<UpdateProfileUseCase<UserModel>>();

  fetchProfile() {
    profileModel = Session.instance.getUser()?.profile;
    state = ViewState.ready;
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

  void onError(ApiException error) {
    status = StatusModel(
        message: error.message, action: "Ok", route: ProfileNavigationSet.home);

    state = ViewState.ready;
    flow = ProfileNavigationSet.home;
  }

  void retry() {
    state = ViewState.ready;
  }
}
