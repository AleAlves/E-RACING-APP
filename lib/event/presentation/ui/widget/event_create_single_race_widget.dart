import 'dart:io';
import 'dart:convert';

import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/session_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import '../../../event_view_model.dart';

class EventCreateSingleRaceWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventCreateSingleRaceWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateSingleRaceWidgetState createState() => _EventCreateSingleRaceWidgetState();
}

class _EventCreateSingleRaceWidgetState extends State<EventCreateSingleRaceWidget>
    implements BaseSateWidget {
  int _index = 0;
  bool allowTeams = false;
  bool allowMembersOnly = false;
  bool hasBroadcasting = false;
  DateTime eventDate = DateTime.now();
  File bannerFile = File('');
  List<ClassesModel?> classesModel = [];
  List<SessionModel?> sessionModel = [];
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final _titleController = TextEditingController();
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
    return Form(
      child: createForm(),
      key: _formKey,
    );
  }

  Widget createForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(text: "Single race", style: Style.title),
          stepper()
        ],
      ),
    );
  }

  Widget stepper() {
    return SizedBox(
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
                title: const Text('Classes'),
                content: classes(),
              ),
              Step(
                title: const Text('Options'),
                content: options(),
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
          finish()
        ],
      ),
    );
  }

  Widget basic() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size32),
        InputTextWidget(
            enabled: true,
            label: "Race Title",
            icon: Icons.title,
            controller: _titleController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Required';
              }
              return null;
            }),
        const SpacingWidget(LayoutSize.size32),
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
                child: bannerFile.path == ''
                    ? Container()
                    : Image.file(
                        bannerFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            ButtonWidget(
                enabled: true,
                type: ButtonType.icon,
                icon: Icons.image_search,
                onPressed: () async {
                  var image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    bannerFile = File(image?.path ?? '');
                  });
                })
          ],
        ),
        const SpacingWidget(LayoutSize.size32),
        const TextWidget(
          text: "Banner: 1000x1000",
          style: Style.description,
          align: TextAlign.start,
        ),
      ],
    );
  }

  Widget options() {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: allowTeams,
              onChanged: (bool? value) {
                setState(() {
                  allowTeams = value ?? false;
                });
              },
            ),
            const TextWidget(
                text: "Allow racing teams", style: Style.description)
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: allowMembersOnly,
              onChanged: (bool? value) {
                setState(() {
                  allowMembersOnly = value ?? false;
                });
              },
            ),
            const TextWidget(
                text: "Allow members only", style: Style.description)
          ],
        )
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
        const SpacingWidget(LayoutSize.size32),
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
          itemCount: sessionModel.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      InputTextWidget(
                          enabled: true,
                          label: "Name",
                          icon: Icons.settings,
                          controller: settingsNamesControllers[index],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            return null;
                          }),
                      const SpacingWidget(LayoutSize.size16),
                      InputTextWidget(
                          enabled: true,
                          label: "Value",
                          icon: Icons.settings,
                          controller: settingsValuesControllers[index],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            return null;
                          }),
                      const SpacingWidget(LayoutSize.size16),
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
                          sessionModel.removeAt(index);
                          settingsNamesControllers.removeAt(index);
                          settingsValuesControllers.removeAt(index);
                        });
                      }),
                )
              ],
            );
          },
        ),
        const SpacingWidget(LayoutSize.size48),
        ButtonWidget(
            enabled: true,
            type: ButtonType.borderless,
            onPressed: () async {
              setState(() {
                var name = TextEditingController();
                var value = TextEditingController();
                sessionModel
                    .add(SessionModel(type: SessionType.race, settings: []));
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
                    enabled: true,
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

  Widget classes() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: classesModel.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      InputTextWidget(
                          enabled: true,
                          label: "Name",
                          icon: Icons.settings,
                          controller: classesNameControllers[index],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            return null;
                          }),
                      const SpacingWidget(LayoutSize.size16),
                      InputTextWidget(
                        enabled: true,
                        label: "Max entries",
                        icon: Icons.settings,
                        controller: classesMaxEntriesControllers[index],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        inputType: InputType.number,
                      ),
                      const SpacingWidget(LayoutSize.size16),
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
                          classesModel.removeAt(index);
                          classesNameControllers.removeAt(index);
                          classesMaxEntriesControllers.removeAt(index);
                        });
                      }),
                )
              ],
            );
          },
        ),
        const SpacingWidget(LayoutSize.size48),
        ButtonWidget(
            enabled: true,
            type: ButtonType.borderless,
            onPressed: () async {
              setState(() {
                var name = TextEditingController();
                var value = TextEditingController();
                classesModel.add(ClassesModel(name: name.text));
                classesNameControllers.add(name);
                classesMaxEntriesControllers.add(value);
              });
            },
            label: 'New class'),
      ],
    );
  }

  Widget finish() {
    return ButtonWidget(
      enabled: _formKey.currentState?.validate() == true,
      type: ButtonType.normal,
      onPressed: () {
        for (var i = 0; i < classesModel.length; i++) {
          classesModel[i]?.name = classesNameControllers[i].text;
          classesModel[i]?.maxEntries =
              int.parse(classesMaxEntriesControllers[i].text);
        }

        List<int> bannerBytes = [];
        try {
          bannerBytes = bannerFile.readAsBytesSync();
        } catch (e) {}
        String bannerImage = base64Encode(bannerBytes);

        var race = RaceModel(
            date: eventDate.toIso8601String(),
            title: _titleController.text,
            broadcasting: hasBroadcasting,
            poster: bannerImage,
            sessions: sessionModel);

        var event = EventModel(
          races: [race],
          classes: classesModel,
          teamsEnabled: allowTeams,
          membersOnly: allowMembersOnly,
        );

        widget.viewModel.create(event);
      },
      label: "Create",
    );
  }
}
