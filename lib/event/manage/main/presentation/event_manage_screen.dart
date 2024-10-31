import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/manage/main/presentation/router/event_manage_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => scaffold());

  @override
  Widget scaffold() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: TextWidget(
          style: Style.subtitle,
          text: viewModel.title,
        ),
      ),
      body: navigate(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget navigate() {
    return EventManageNavigation.flow(viewModel);
  }
}
