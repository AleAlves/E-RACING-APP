import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/create/presentation/event_create_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ui/component/ui/step_progress_indicator_widget.dart';
import '../navigation/event_create_flow.dart';

class EventCreateScreen extends StatefulWidget {
  final EventCreateNavigator flow;

  const EventCreateScreen(this.flow, {super.key});

  @override
  EventCreateScreenState createState() => EventCreateScreenState();
}

class EventCreateScreenState extends State<EventCreateScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<EventCreateViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.flow = widget.flow;
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => scaffold());

  @override
  Widget scaffold() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Event creation'),
      ),
      body: Stack(
        children: [
          progressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: navigate(),
          ),
        ],
      ),
    );
  }

  Widget progressIndicator() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: StepProgressIndicatorWidget(
        maxSteps: viewModel.maxSteps,
        currentStep: viewModel.currentStep,
      ),
    );
  }

  @override
  Widget navigate() {
    return EventCreateNavigation.flow(viewModel);
  }
}
