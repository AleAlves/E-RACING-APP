import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/ui/icon_widget.dart';
import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventManagementRaceListWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventManagementRaceListWidget(this.viewModel, {Key? key})
      : super(key: key);

  @override
  _EventManagementRaceListWidgetState createState() =>
      _EventManagementRaceListWidgetState();
}

class _EventManagementRaceListWidgetState
    extends State<EventManagementRaceListWidget> implements BaseSateWidget {
  @override
  void initState() {
    observers();
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
        state: widget.viewModel.state,
        scrollable: true,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlow.manager);
    return false;
  }

  @override
  Widget content() {
    return races();
  }

  Widget races() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 24.0),
      child: Column(
        children: [
          const TextWidget(text: "Races", style: Style.title),
          const SpacingWidget(LayoutSize.size24),
          ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.viewModel.event?.races?.length,
            itemBuilder: (context, index) {
              return raceCard(widget.viewModel.event?.races?[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget raceCard(RaceModel? raceModel) {
    return CardWidget(
      childLeft: const SizedBox(
        width: 8,
        height: 8,
      ),
      onPressed: () {
        Session.instance.setRaceId(raceModel?.id);
        widget.viewModel.editRace();
      },
      ready: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextWidget(
                            text: raceModel?.title, style: Style.title),
                      ),
                    ],
                  ),
                ],
              ),
              const IconWidget(
                icon: Icons.chevron_right,
                borderless: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}