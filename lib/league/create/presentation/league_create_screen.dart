import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/component/ui/step_progress_indicator_widget.dart';
import 'league_create_view_model.dart';
import 'navigation/league_create_flow.dart';

class LeagueCreateScreen extends StatefulWidget {
  final LeagueCreateNavigator flow;

  const LeagueCreateScreen(this.flow, {Key? key}) : super(key: key);

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueCreateScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueCreateViewModel>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('League Creation'),
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
    });
  }

  Widget progressIndicator() {
    return Positioned(
      child: StepProgressIndicatorWidget(
        maxSteps: viewModel.maxSteps,
        currentStep: viewModel.currentStep,
      ),
      left: 0,
      right: 0,
      top: 0,
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
