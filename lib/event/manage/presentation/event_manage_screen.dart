import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/manage/presentation/router/event_manage_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'event_manage_view_model.dart';

class EventManageScreen extends StatefulWidget {
  const EventManageScreen({Key? key}) : super(key: key);

  @override
  _EventManageScreenState createState() => _EventManageScreenState();
}

class _EventManageScreenState extends State<EventManageScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<EventManageViewModel>();

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Stack(
        children: [
          Observer(builder: (_) {
            return navigate();
          })
        ],
      ),
    );
  }

  @override
  Widget navigate() {
    return EventManageNavigation.flow(viewModel);
  }
}
