import 'dart:io';

import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../main.dart';
import '../../../event_view_model.dart';

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
  int _index = 0;
  bool hasBroadcasting = false;
  DateTime eventDate = DateTime.now();
  File posterFile = File('');
  List<ClassesModel?> classesModel = [];
  List<SettingsModel?> settingsModel = [];
  List<RaceModel?> raceModels = [];
  List<MediaModel?> mediaModels = [];
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  final _broadcastingLinkController = TextEditingController();
  List<TextEditingController> settingsNamesControllers = [];
  List<TextEditingController> settingsValuesControllers = [];
  List<TextEditingController> classesNameControllers = [];
  List<TextEditingController> classesMaxEntriesControllers = [];

  @override
  void initState() {
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
        state: widget.viewModel.state,
        scrollable: true,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }

  @override
  Widget content() {
    return Expanded(child: races());
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
            itemCount: raceModels.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: Text("Race #$index"),
                            children: [
                              createForm(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
                    raceModels.add(RaceModel(date: null, title: null, hour: null));
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
                    raceModels.removeLast();
                  });
                },
                label: 'Remove'),
          ],),
          const BoundWidget(BoundType.xl),
          finish()
        ],
      ),
    );
  }

  Widget createForm() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(text: "Race", style: Style.title),
            stepper()
          ],
        ),
      ),
      key: _formKey,
    );
  }

  Widget stepper() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        child: Column(
          children: [
            Stepper(
              physics: const ClampingScrollPhysics(),
              currentStep: _index,
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                });
              },
              controlsBuilder: (BuildContext context,
                  {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                return Row(
                  children: <Widget>[
                    Container(),
                    Container(),
                  ],
                );
              },
              steps: <Step>[
                Step(
                  title: const Text('Basic'),
                  content: basic(),
                ),
                Step(
                  title: const Text('Date'),
                  content: date(),
                ),
                Step(
                  title: const Text('Poster'),
                  content: banner(),
                ),
                Step(
                  title: const Text('Settings'),
                  content: settings(),
                ),
                Step(
                  title: const Text('Broadcast'),
                  content: broadcasting(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget basic() {
    return Column(
      children: [
        const BoundWidget(BoundType.huge),
        InputTextWidget(
            label: "Race Title",
            icon: Icons.title,
            controller: _titleController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Required';
              }
              return null;
            }),
        const BoundWidget(BoundType.huge),
        InputTextWidget(
            label: "Notes",
            icon: Icons.title,
            controller: _notesController,
            validator: (value) {
              return null;
            },
            inputType: InputType.multilines),
        const BoundWidget(BoundType.huge),
      ],
    );
  }

  Widget banner() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.height,
                child: posterFile.path == ''
                    ? Container(
                        color: ERcaingApp.color.shade100,
                      )
                    : Image.file(
                        posterFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            IconButtonWidget(Icons.image_search, () async {
              var image = await _picker.pickImage(source: ImageSource.gallery);
              setState(() {
                posterFile = File(image?.path ?? '');
              });
            })
          ],
        ),
        const BoundWidget(BoundType.huge),
        const TextWidget(
          text: "Banner: 1000x1000",
          style: Style.description,
          align: TextAlign.start,
        ),
      ],
    );
  }

  Widget date() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWidget(
            text:
                "${eventDate.hour}:${eventDate.minute}, ${eventDate.day}/${eventDate.month}/${eventDate.year} ",
            style: Style.subtitle),
        const BoundWidget(BoundType.huge),
        ButtonWidget(
            icon: Icons.date_range,
            enabled: true,
            type: ButtonType.icon,
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: false,
                  minTime: DateTime.now(), onChanged: (date) {
                setState(() {
                  eventDate = date;
                });
              }, currentTime: DateTime.now());
            }),
      ],
    );
  }

  Widget settings() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: settingsModel.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      InputTextWidget(
                          label: "Name",
                          icon: Icons.settings,
                          controller: settingsNamesControllers[index],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            return null;
                          }),
                      const BoundWidget(BoundType.medium),
                      InputTextWidget(
                          label: "Value",
                          icon: Icons.settings,
                          controller: settingsValuesControllers[index],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            return null;
                          }),
                      const BoundWidget(BoundType.medium),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                      enabled: true,
                      type: ButtonType.icon,
                      icon: Icons.delete,
                      onPressed: () {
                        setState(() {
                          settingsModel.removeAt(index);
                          settingsNamesControllers.removeAt(index);
                          settingsValuesControllers.removeAt(index);
                        });
                      }),
                )
              ],
            );
          },
        ),
        const BoundWidget(BoundType.xl),
        ButtonWidget(
            enabled: true,
            type: ButtonType.borderless,
            onPressed: () async {
              setState(() {
                var name = TextEditingController();
                var value = TextEditingController();
                settingsModel
                    .add(SettingsModel(name: name.text, value: value.text));
                settingsNamesControllers.add(name);
                settingsValuesControllers.add(value);
              });
            },
            label: 'New setting'),
      ],
    );
  }

  Widget broadcasting() {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: ERcaingApp.ascent,
              value: hasBroadcasting,
              onChanged: (bool? value) {
                setState(() {
                  hasBroadcasting = value ?? false;
                });
              },
            ),
            const TextWidget(
                text: "Live broadcasting", style: Style.description),
          ],
        ),
        if (hasBroadcasting)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InputTextWidget(
                    label: "link",
                    icon: Icons.settings,
                    controller: _broadcastingLinkController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonWidget(
                    enabled: true,
                    type: ButtonType.icon,
                    onPressed: () async {
                      Clipboard.getData(Clipboard.kTextPlain).then((value) {
                        _broadcastingLinkController.text =
                            value?.text?.trim().replaceAll(' ', '') ?? '';
                      });
                    },
                    icon: Icons.paste),
              )
            ],
          )
        else
          Container(),
      ],
    );
  }

  Widget finish() {
    return ButtonWidget(
      enabled: _formKey.currentState?.validate() == true,
      type: ButtonType.normal,
      onPressed: () {
        widget.viewModel.createChampionshipRacesStep(raceModels, mediaModels);
      },
      label: "Create",
    );
  }
}
