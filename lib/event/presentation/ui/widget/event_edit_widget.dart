import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/scoring_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../event_view_model.dart';

class EventEditWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventEditWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventEditWidgetState createState() => _EventEditWidgetState();
}

class _EventEditWidgetState extends State<EventEditWidget>
    implements BaseSateWidget {
  int _index = 0;
  bool allowTeams = false;
  bool allowMembersOnly = false;
  File bannerFile = File('');
  List<int?>? score = [];
  List<ClassesModel?>? classesModel = [];
  List<SettingsModel?>? settingsModel = [];
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final _titleController = TextEditingController();
  final _rulesController = TextEditingController();
  List<Pair<TextEditingController, TextEditingController>> settingsControllers =
      [];
  List<Pair<TextEditingController, TextEditingController>> classesControllers =
      [];

  bool editingClasses = false;
  bool editingSettings = false;

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
  observers() async {
    settingsModel = [];
    classesModel = [];
    classesControllers = [];
    settingsControllers = [];
    bannerFile = widget.viewModel.bannerFile ?? File('');
    if (_titleController.text.isEmpty) {
      _titleController.text = widget.viewModel.event?.title ?? '';
    }
    if (_rulesController.text.isEmpty) {
      _rulesController.text = widget.viewModel.event?.rules ?? '';
    }
    widget.viewModel.event?.classes?.forEach((clazz) {
      _setupClassEditor(clazz);
    });
    widget.viewModel.event?.settings?.forEach((setting) {
      _setupSettingsEditor(setting);
    });
    score = widget.viewModel.event?.scoring;
  }

  void _setupClassEditor(ClassesModel? clazz) {
    var name = TextEditingController();
    var value = TextEditingController();
    name.text = clazz?.name ?? '';
    value.text = clazz?.maxEntries.toString() ?? "";
    classesModel?.add(ClassesModel(
        name: name.text,
        id: clazz?.id,
        drivers: clazz?.drivers,
        maxEntries: clazz?.maxEntries));
    classesControllers.add(Pair(name, value));
  }

  void _setupSettingsEditor(SettingsModel? settings) {
    var name = TextEditingController();
    var value = TextEditingController();
    name.text = settings?.name ?? '';
    value.text = settings?.value ?? '';
    settingsModel?.add(SettingsModel(name: name.text, value: value.text));
    settingsControllers.add(Pair(name, value));
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
    widget.viewModel.setFlow(EventFlow.manager);
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
          const TextWidget(text: "Event", style: Style.title),
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
            steps: <Step>[
              Step(
                title: const Text('Basic'),
                content: basic(),
              ),
              Step(
                title: const Text('Score'),
                content: scoring(),
              ),
              Step(
                title: const Text('Classes'),
                content: classes(),
              ),
              Step(
                title: const Text('Banner'),
                content: banner(),
              ),
              Step(
                title: const Text('Settings'),
                content: settings(),
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
            label: "Title",
            icon: Icons.title,
            controller: _titleController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Required';
              }
              return null;
            }),
        const SpacingWidget(LayoutSize.size32),
        InputTextWidget(
            enabled: true,
            label: "Rules",
            icon: Icons.title,
            controller: _rulesController,
            validator: (value) {
              return null;
            },
            inputType: InputType.multilines),
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
                    ? Image.memory(
                        base64Decode(widget.viewModel.media?.image ?? ''),
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        bannerFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconButton,
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
          style: Style.paragraph,
          align: TextAlign.start,
        ),
      ],
    );
  }

  Widget scoring() {
    return ScoringWidget(
      editing: true,
      scoring: widget.viewModel.event?.scoring,
      onScore: (scoring) {
        score = scoring;
      },
    );
  }

  Widget settings() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: settingsModel!.length,
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
                          controller: settingsControllers[index].first,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            editingSettings = true;
                            return null;
                          }),
                      const SpacingWidget(LayoutSize.size16),
                      InputTextWidget(
                          enabled: true,
                          label: "Value",
                          icon: Icons.settings,
                          controller: settingsControllers[index].second,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            editingSettings = true;
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
                      type: ButtonType.iconButton,
                      icon: Icons.delete,
                      onPressed: () {
                        setState(() {
                          settingsModel?.removeAt(index);
                          settingsControllers.removeAt(index);
                        });
                      }),
                )
              ],
            );
          },
        ),
      ],
    );
  }

  Widget classes() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: classesModel!.length,
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
                          controller: classesControllers[index].first,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            editingClasses = true;
                            return null;
                          }),
                      const SpacingWidget(LayoutSize.size16),
                      InputTextWidget(
                        enabled: true,
                        label: "Max entries",
                        icon: Icons.settings,
                        controller: classesControllers[index].second,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "required";
                          }
                          editingClasses = true;
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
                      type: ButtonType.iconButton,
                      icon: Icons.delete,
                      onPressed: () {
                        setState(() {
                          classesModel?.removeAt(index);
                          classesControllers.removeAt(index);
                        });
                      }),
                )
              ],
            );
          },
        ),
      ],
    );
  }

  Widget finish() {
    return ButtonWidget(
      enabled: _formKey.currentState?.validate() == true,
      type: ButtonType.primary,
      onPressed: () {
        if (editingClasses) {
          for (var i = 0; i < classesControllers.length; i++) {
            classesModel?[i]?.name = classesControllers[i].first?.text;
            classesModel?[i]?.maxEntries =
                int.parse(classesControllers[i].second?.text ?? '');
          }
        }
        if (editingSettings) {
          for (var i = 0; i < settingsControllers.length; i++) {
            settingsModel?[i]?.name = settingsControllers[i].first?.text;
            settingsModel?[i]?.value = settingsControllers[i].second?.text;
          }
        }
        var event = widget.viewModel.event;
        event?.settings = settingsModel;
        event?.classes = classesModel;
        event?.title = _titleController.text;
        event?.rules = _rulesController.text;
        event?.scoring = score;
        List<int> bannerBytes = [];
        try {
          bannerBytes = bannerFile.readAsBytesSync();
        } catch (e) {}
        String bannerImage = base64Encode(bannerBytes);
        var media = MediaModel(bannerImage);
        widget.viewModel.updateEvent(event as EventModel, media);
      },
      label: "Update",
    );
  }
}
