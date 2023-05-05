import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/list/presentation/router/event_list_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/component/ui/text_widget.dart';
import 'event_list_view_model.dart';

class EventListScreen extends StatefulWidget {
  final EventListRouter? router;

  const EventListScreen({this.router, Key? key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<EventListViewModel>();

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
    viewModel.flow = widget.router;
  }

  @override
  Widget navigate() {
    return EventListNavigation.flow(viewModel);
  }
}
