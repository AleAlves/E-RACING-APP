import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:mobx/mobx.dart';

import '../model/status_model.dart';
import '../service/api_exception.dart';

abstract class BaseViewModel<T> with Store {
  @observable
  abstract T? flow;

  @observable
  StatusModel? status;

  @observable
  ViewState state = ViewState.ready;

  void onError(ApiException route) {
    state = ViewState.error;
  }

  void onNavigate(T route) {
    flow = route;
  }
}
