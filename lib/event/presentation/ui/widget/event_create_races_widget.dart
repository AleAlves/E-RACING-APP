import 'dart:io';

import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:e_racing_app/event/presentation/ui/model/championship_races_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import '../../../event_view_model.dart';
import '../../../../core/ui/component/ui/event_create_races_widget.dart';

class CreateChampionshipRaceWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const CreateChampionshipRaceWidget(this.viewModel, {Key? key})
      : super(key: key);

  @override
  _CreateChampionshipRaceWidgetState createState() =>
      _CreateChampionshipRaceWidgetState();
}

class _CreateChampionshipRaceWidgetState
    extends State<CreateChampionshipRaceWidget> implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
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
    racesModel = widget.viewModel.racesModel ?? [];
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        scrollable: true,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlows.createEvent);
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
                    onPressed: () {},
                    ready: true,
                    child: ExpansionTile(
                      title: Text("Race #${++index}"),
                      children: [EventCreateRacesWidget(racesModel[--index])],
                    )),
              );
            },
          ),
          const BoundWidget(BoundType.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  enabled: true,
                  icon: Icons.add,
                  type: ButtonType.icon,
                  onPressed: () async {
                    setState(() {
                      racesModel.add(ChampionshipRacesModel(
                          eventDate: DateTime.now(),
                          hasBroadcasting: false,
                          settingsModel:[],
                          picker: ImagePicker(),
                          posterFile: File(''),
                          titleController: TextEditingController(),
                          notesController: TextEditingController(),
                          broadcastingLinkController: TextEditingController(),
                          settingsControllers: []));

                      widget.viewModel.updateChampionshipRaces(racesModel);
                    });
                  },
                  label: 'Add'),
              const BoundWidget(BoundType.xl),
              ButtonWidget(
                  enabled: true,
                  icon: Icons.remove,
                  type: ButtonType.icon,
                  onPressed: () async {
                    setState(() {
                      racesModel.removeLast();
                      widget.viewModel.updateChampionshipRaces(racesModel);
                    });
                  },
                  label: 'Remove'),
            ],
          ),
          const BoundWidget(BoundType.xl),
          finish()
        ],
      ),
    );
  }

  Widget finish() {
    return ButtonWidget(
      enabled: racesModel.length > 1,
      type: ButtonType.normal,
      onPressed: () {
        widget.viewModel.createChampionshipRacesStep(racesModel);
      },
      label: "Create championship",
    );
  }
}
