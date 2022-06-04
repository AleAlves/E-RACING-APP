import 'package:flutter/cupertino.dart';

import '../notification_view_model.dart';
import '../widget/notification_list_widget.dart';

enum NotificationsFlow {
  home
}

extension NotificationsNavigation on NotificationsFlow {
  static Widget flow(NotificationViewModel vm) {
    switch (vm.flow) {
      case NotificationsFlow.home:
        return NotificationListWidget(vm);
      default:
        return NotificationListWidget(vm);
    }
  }
}