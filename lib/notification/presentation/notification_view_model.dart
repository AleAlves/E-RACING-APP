import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'package:e_racing_app/notification/presentation/ui/notification_flow.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/service/api_exception.dart';
import '../domain/get_notifications_usecase.dart';

part 'notification_view_model.g.dart';

class NotificationViewModel = _NotificationViewModel
    with _$NotificationViewModel;

abstract class _NotificationViewModel with Store {
  _NotificationViewModel();

  @observable
  NotificationsFlow flow = NotificationsFlow.home;

  @observable
  ViewState state = ViewState.ready;

  @observable
  ProfileModel? profileModel;

  @observable
  ObservableList<QueryDocumentSnapshot?>? notifications = ObservableList();

  @observable
  StatusModel? status;

  final _getNotificationsUC =
      Modular.get<GetNotificationsUseCase<List<QueryDocumentSnapshot>>>();

  fetchProfile() {
    state = ViewState.ready;
    profileModel = Session.instance.getUser()?.profile;
  }

  fetchNotifications() {
    _getNotificationsUC.invoke(
        success: (data) {
          notifications = ObservableList.of(data!);
        },
        error: onError);
  }

  void retry() {
    state = ViewState.ready;
  }

  void onError(ApiException error) {
    state = ViewState.ready;
  }
}
