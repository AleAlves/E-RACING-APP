import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/ui/component/ui/text_widget.dart';
import 'notification_view_model.dart';
import 'ui/notification_flow.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NotificationScreen> {
  final NotificationViewModel vm = NotificationViewModel();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: TextWidget(
        text: 'Notifications',
        style: Style.title,
      )),
      body: Stack(
        children: [
          Observer(builder: (_) {
            return navigation();
          })
        ],
      ),
    );
  }

  Widget navigation() {
    return PushNotificationNavigation.flow(vm);
  }
}
