
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/get_notifications_flow_usecase.dart';
import '../domain/get_notifications_usecase.dart';
import '../presentation/notification_view_model.dart';
import '../presentation/ui/notification_screen.dart';


class NotificationModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory((i) => NotificationViewModel()),
    Bind.factory((i) => GetNotificationsUseCase<List<QueryDocumentSnapshot>>()),
    Bind.factory((i) => GetNotificationsFlowUseCase<String>()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const NotificationScreen())
  ];
}
