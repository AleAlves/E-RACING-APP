import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/full_standings_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/teams_standings_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventFullStandingsWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventFullStandingsWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventFullStandingsWidgetState createState() => _EventFullStandingsWidgetState();
}

class _EventFullStandingsWidgetState extends State<EventFullStandingsWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.getRaceTeamsStandings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlow.eventDetail);
    return false;
  }

  @override
  Widget content() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: generalStandings(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: teamsStandings(),
        ),
      ],
    );
  }

  Widget generalStandings(){
    return FullStandingsWidget(
      standings: widget.viewModel.standings,
      onRaceCardPressed: (id) {}, onFullStandingsPressed: (){},
    );
  }

  Widget teamsStandings(){
    return TeamsStandingsWidget(
      standings: widget.viewModel.raceTeamsStandings
    );
  }
}
