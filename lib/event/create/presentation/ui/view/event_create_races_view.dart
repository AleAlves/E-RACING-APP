import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../../../presentation/ui/model/championship_races_model.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateRacesView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateRacesView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateRacesViewState createState() => _EventCreateRacesViewState();
}

class _EventCreateRacesViewState extends State<EventCreateRacesView>
    implements BaseSateWidget {
  @override
  void initState() {
    observers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainObserver();
  }

  @override
  Observer mainObserver() {
    return Observer(builder: (_) => viewState());
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: button(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titleWidget(),
          const SpacingWidget(LayoutSize.size48),
          racesWidget(),
          const SpacingWidget(LayoutSize.size48),
          addRaceWidget()
        ],
      ),
    );
  }

  @override
  observers() {}

  Widget titleWidget() {
    return const TextWidget(
        text: "Create the races of your competion", style: Style.subtitle);
  }

  Widget racesWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: widget.viewModel.racesModel
            .map((race) {
              return CardWidget(
                ready: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      TextWidget(
                          text: "${race?.titleController?.text}",
                          style: Style.paragraph),
                    ],
                  ),
                ),
                childRight: removeWidget(race),
              );
            })
            .toList()
            .cast<Widget>(),
      ),
    );
  }

  Widget removeWidget(ChampionshipRacesModel? racesModel) {
    return ButtonWidget(
        enabled: true,
        type: ButtonType.iconPure,
        icon: Icons.delete,
        onPressed: () {
          setState(() {
            widget.viewModel.removeRace(racesModel);
          });
        });
  }

  Widget addRaceWidget() {
    return ButtonWidget(
        enabled: true,
        type: ButtonType.iconButton,
        icon: Icons.add,
        onPressed: () {
          widget.viewModel.onNavigate(EventCreateNavigator.raceCreation);
        },
        label: 'New Race');
  }

  Widget button() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.createEvent();
      },
      label: "Finish",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(EventCreateNavigator.settings);
    return false;
  }
}
