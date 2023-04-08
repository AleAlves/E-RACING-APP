import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/create/presentation/event_create_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../navigation/event_create_flow.dart';

class EventCreateScreen extends StatefulWidget {
  final EventCreateNavigator flow;

  const EventCreateScreen(this.flow, {Key? key}) : super(key: key);

  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<EventCreateViewModel>();

  @override
  void initState() {
    viewModel.onNavigate(widget.flow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Event creation'),
        ),
        body: navigate(),
      );
    });
  }

  @override
  Widget navigate() {
    return EventCreateNavigation.flow(viewModel);
  }
}
