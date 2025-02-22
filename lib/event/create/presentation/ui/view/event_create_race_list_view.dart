import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/card_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../../../core/data/session_race_model.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateRaceListView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateRaceListView(this.viewModel, {super.key});

  @override
  EventCreateRaceListViewState createState() => EventCreateRaceListViewState();
}

class EventCreateRaceListViewState extends State<EventCreateRaceListView>
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
      bottom: buttonWidget(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Center(
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size128),
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
        text: "New Race",
        style: Style.subtitle);
  }

  Widget racesWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: widget.viewModel.racesModel
            .map((race) {
              return CardWidget(
                ready: true,
                onPressed: () {
                  widget.viewModel.onRaceEditing(race);
                },
                childLeft: removeWidget(race),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: "${race?.title}",
                            style: Style.paragraph,
                            align: TextAlign.start,
                          ),
                          const SpacingWidget(LayoutSize.size16),
                          TextWidget(
                              text: "${race?.eventDate}",
                              style: Style.paragraph),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
            .toList()
            .cast<Widget>(),
      ),
    );
  }

  Widget removeWidget(EventRaceModel? racesModel) {
    return ButtonWidget(
        enabled: true,
        type: ButtonType.iconShapeless,
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
        type: ButtonType.icon,
        icon: Icons.add,
        onPressed: () {
          widget.viewModel.onCreateNewRace();
        },
        label: 'New Race');
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: widget.viewModel.racesModel.isNotEmpty,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.createEvent();
      },
      label: "Finish",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep();
    return false;
  }
}
