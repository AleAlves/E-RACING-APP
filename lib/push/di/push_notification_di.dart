import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/get_notifications_flow_usecase.dart';
import '../domain/get_notifications_usecase.dart';
import '../presentation/notification_screen.dart';
import '../presentation/notification_view_model.dart';

class NotificationModule extends Module {

  @override
  void binds(i) {
    i.add<NotificationViewModel>(NotificationViewModel.new);
    i.add<GetNotificationsUseCase<List<QueryDocumentSnapshot>>>(GetNotificationsUseCase<List<QueryDocumentSnapshot>>.new);
    i.add<GetNotificationsFlowUseCase<String>>(GetNotificationsFlowUseCase<String>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const NotificationScreen());
  }
}
