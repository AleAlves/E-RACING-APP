import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/full_standings_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/teams_standings_widget.dart';
import '../event_detail_view_model.dart';
import '../router/event_detail_router.dart';

class EventDetailStandingsView extends StatefulWidget {
  final EventDetailViewModel viewModel;

  const EventDetailStandingsView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventDetailStandingsViewState createState() =>
      _EventDetailStandingsViewState();
}

class _EventDetailStandingsViewState extends State<EventDetailStandingsView>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.getTeamsStandings();
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
        body: content(),
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(EventDetailRouter.main);
    return false;
  }

  @override
  Widget content() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: generalStandings(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: teamsStandings(),
        ),
      ],
    );
  }

  Widget generalStandings() {
    return FullStandingsWidget(standings: widget.viewModel.standings);
  }

  Widget teamsStandings() {
    return TeamsStandingsWidget(standings: widget.viewModel.teamsStandings);
  }
}
