import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/detail/presentation/event_detail_view_model.dart';
import 'package:e_racing_app/event/detail/presentation/router/event_detail_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/component/ui/share_widget.dart';
import '../../../core/ui/component/ui/text_widget.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  EventDetailScreenState createState() => EventDetailScreenState();
}

class EventDetailScreenState extends State<EventDetailScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<EventDetailViewModel>();

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
            style: Style.title,
            text: viewModel.title,
          ),
          actions: [ShareWidget(model: viewModel.share)],
        ),
        body: navigate());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget navigate() {
    return EventDetailNavigation.flow(viewModel);
  }
}
