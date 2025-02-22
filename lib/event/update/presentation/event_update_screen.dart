import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/update/presentation/event_update_view_model.dart';
import 'package:e_racing_app/event/update/presentation/router/event_update_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/component/ui/text_widget.dart';

class EventUpdateScreen extends StatefulWidget {
  const EventUpdateScreen({Key? key}) : super(key: key);

  @override
  _EventUpdateScreenState createState() => _EventUpdateScreenState();
}

class _EventUpdateScreenState extends State<EventUpdateScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<EventUpdateViewModel>();

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
        text: 'Edit event',
        style: Style.title,
      )),
      body: navigate(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget navigate() {
    return EventUpdateNavigation.flow(viewModel);
  }
}
