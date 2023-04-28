import 'package:flutter/cupertino.dart';

import '../notification_view_model.dart';
import '../widget/notification_list_widget.dart';

enum PushNotificationRouter { home }

extension PushNotificationNavigation on PushNotificationRouter {
  static Widget flow(NotificationViewModel vm) {
    switch (vm.flow) {
      case PushNotificationRouter.home:
        return NotificationListWidget(vm);
      default:
        return NotificationListWidget(vm);
    }
  }
}
