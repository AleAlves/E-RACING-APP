import 'dart:developer';

import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:mobx/mobx.dart';

import '../model/status_model.dart';
import '../service/api_exception.dart';

abstract class BaseViewModel<Router> with Store {
  @observable
  abstract Router? flow;

  List<Router?> previouslyFlow = [];

  @observable
  abstract String? title;

  @observable
  abstract StatusModel? status;

  @observable
  abstract ViewState state;

  @observable
  String? error;

  void onError(ApiException route) {
    log('#### ERROR : $error');
    error = route.message;
    state = ViewState.failure;
  }

  void onRoute(Router route) {
    previouslyFlow.add(flow);
    flow = route;
  }

  void pop() {
    flow = previouslyFlow.last;
    previouslyFlow.removeLast();
  }
}
