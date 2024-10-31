import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/model/status_model.dart';
import '../../core/tools/session.dart';
import '../../core/ui/view_state.dart';
import '../../login/legacy/domain/model/user_model.dart';
import '../../login/login_router.dart';
import '../domain/get_tutorial_exhibition_usecase.dart';
import 'navigation/app_navigation.dart';

part 'app_view_model.g.dart';

class AppViewModel = _LoginViewModel with _$AppViewModel;

abstract class _LoginViewModel extends BaseViewModel<AppNavigationSet>
    with Store {
  _LoginViewModel();

  @override
  @observable
  AppNavigationSet? flow = AppNavigationSet.appEnvironment;

  @override
  @observable
  ViewState state = ViewState.ready;

  @observable
  UserModel? user;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "";

  final _getExhibition = Modular.get<GetTutorialExhibitionUserUseCase<bool>>();

  setUrl(String? value) {
    Session.instance.setURL(value ?? '');
    _getTutorialExhibition();
  }

  _getTutorialExhibition() async {
    state = ViewState.loading;
    await _getExhibition.invoke(
        success: (data) {
          if (data == true) {
            Modular.to.pushNamed(LoginRouter.signIn);
          } else {
            Modular.to.pushNamed(LoginRouter.onboard);
          }
          state = ViewState.ready;
        },
        failure: onError);
  }
}
