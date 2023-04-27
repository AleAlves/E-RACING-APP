import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_edit_races_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../event_view_model.dart';
import '../event_flow.dart';
import '../model/championship_races_model.dart';

class EventCreateRacesWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventCreateRacesWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateRacesWidgetState createState() => _EventCreateRacesWidgetState();
}

class _EventCreateRacesWidgetState extends State<EventCreateRacesWidget>
    implements BaseSateWidget {
  List<ChampionshipRacesModel> racesModel = [];

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
  observers() {
    // racesModel = widget.viewModel.racesModel ?? [];
  }

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
    widget.viewModel.setFlow(EventFlow.createEvent);
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
          ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: racesModel.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardWidget(
                  ready: true,
                  child: ExpansionTile(
                    title: Text("Race #${++index}"),
                    children: [EventEditRacesWidget(racesModel[--index])],
                  ),
                ),
              );
            },
          ),
          const SpacingWidget(LayoutSize.size48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  enabled: true,
                  icon: Icons.add,
                  type: ButtonType.iconButton,
                  onPressed: () async {
                    setState(() {
                      racesModel.add(ChampionshipRacesModel(
                          eventDate: DateTime.now().toIso8601String(),
                          hasBroadcasting: false,
                          title: TextEditingController().text,
                          sessions: []));

                      widget.viewModel.updateChampionshipRaces(racesModel);
                    });
                  },
                  label: 'Add'),
              const SpacingWidget(LayoutSize.size48),
              ButtonWidget(
                  enabled: true,
                  icon: Icons.remove,
                  type: ButtonType.iconButton,
                  onPressed: () async {
                    setState(() {
                      racesModel.removeLast();
                      widget.viewModel.updateChampionshipRaces(racesModel);
                    });
                  },
                  label: 'Remove'),
            ],
          ),
          const SpacingWidget(LayoutSize.size48),
          finish(),
          const SpacingWidget(LayoutSize.size48),
        ],
      ),
    );
  }

  Widget finish() {
    return ButtonWidget(
      enabled: racesModel.length > 1,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.createChampionshipRacesStep(racesModel);
      },
      label: "Create championship",
    );
  }
}
