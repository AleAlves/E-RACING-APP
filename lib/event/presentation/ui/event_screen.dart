import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/event_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'event_flow.dart';

class EventScreen extends StatefulWidget {

  final EventFlows? flows;

  const EventScreen({this.flows, Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<EventViewModel>();
  ViewState? curentState;

  @override
  void initState() {
    viewModel.setFlow(widget.flows ??  EventFlows.list);
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
    return EventNavigation.flow(viewModel);
  }
}