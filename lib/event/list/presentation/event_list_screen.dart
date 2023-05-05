import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/list/presentation/router/event_list_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'event_list_view_model.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<EventListViewModel>();

  @override
  void initState() {
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
    return EventListNavigation.flow(viewModel);
  }
}
