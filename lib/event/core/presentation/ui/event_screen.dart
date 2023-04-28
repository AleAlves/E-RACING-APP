import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../event_view_model.dart';
import 'event_flow.dart';

class EventScreen extends StatefulWidget {
  final EventFlow? flow;

  const EventScreen({this.flow, Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<EventViewModel>();

  @override
  void initState() {
    viewModel.setFlow(widget.flow ?? EventFlow.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Events'),
        ),
        body: navigate(),
      );
    });
  }

  @override
  Widget navigate() {
    return EventNavigation.flow(viewModel);
  }
}