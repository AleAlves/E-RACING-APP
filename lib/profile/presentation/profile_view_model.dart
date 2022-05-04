import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'package:e_racing_app/login/domain/usecase/sign_in_usecase.dart';
import 'package:e_racing_app/profile/presentation/ui/profile_flow.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModel with _$ProfileViewModel;

abstract class _ProfileViewModel with Store {
  _ProfileViewModel();

  final signInUseCase = Modular.get<SignInUseCase<StatusModel>>();

  @observable
  ProfileFlow flow = ProfileFlow.error;

  @observable
  ViewState state = ViewState.loading;

  @observable
  ProfileModel? profileModel;

  @observable
  StatusModel? status;

  fetchProfile() {
    profileModel = Session.instance.getUser()?.profile;
    state = ViewState.ready;
  }

  void udpate(String name, String surname, String mail, String country) async {
    state = ViewState.loading;
    await signInUseCase
        .params(
            name: name,
            surname: surname,
            email: mail,
            password: "password",
            country: country)
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
              flow = ProfileFlow.home;
            },
            error: onError);
  }

  void onError(ApiException error) {
    status = StatusModel(
        message: error.message,
        action: "Ok",
        next: ProfileFlow.home,
        previous: flow);

    state = ViewState.ready;
    flow = ProfileFlow.home;
  }

  void retry() {
    state = ViewState.ready;
  }
}
