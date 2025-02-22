import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/component/ui/step_progress_indicator_widget.dart';
import '../../../core/ui/component/ui/text_widget.dart';
import 'league_create_view_model.dart';
import 'navigation/league_create_flow.dart';

class LeagueCreateScreen extends StatefulWidget {
  final LeagueCreateNavigator flow;

  const LeagueCreateScreen(this.flow, {super.key});

  @override
  LeagueScreenState createState() => LeagueScreenState();
}

class LeagueScreenState extends State<LeagueCreateScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueCreateViewModel>();

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
            text: 'Community creating',
            style: Style.title,
          )
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
  void initState() {
    viewModel.onRoute(widget.flow);
    super.initState();
  }

  @override
  Widget navigate() {
    return LeagueCreateNavigation.flow(viewModel);
  }
}
