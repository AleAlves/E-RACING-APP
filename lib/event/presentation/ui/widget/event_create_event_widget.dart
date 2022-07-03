import 'dart:io';
import 'dart:convert';

import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/scoring_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/ui/component/ui/stepper_widget.dart';
import '../../../event_view_model.dart';

class EventCreateEventWidget extends StatefulWidget {
  final EventViewModel vm;

  const EventCreateEventWidget(this.vm, {Key? key}) : super(key: key);

  @override
  _EventCreateEventWidgetState createState() => _EventCreateEventWidgetState();
}

class _EventCreateEventWidgetState extends State<EventCreateEventWidget>
    implements BaseSateWidget {
  bool allowTeams = false;
  bool allowMembersOnly = false;
  File bannerFile = File('');
  List<int?> score = [];
  List<String?> tags = [];
  List<ClassesModel?> classesModel = [];
  List<SettingsModel?> settingsModel = [];
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final _titleController = TextEditingController();
  final _rulesController = TextEditingController();
  List<Pair<TextEditingController, TextEditingController>> settingsControllers =
      [];
  List<Pair<TextEditingController, TextEditingController>> classesControllers =
      [];

  @override
  void initState() {
    observers();
    widget.vm.fetchTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {
    settingsModel.clear();
    classesModel.clear();
    classesControllers.clear();
    settingsControllers.clear();
    _titleController.text = widget.vm.creatingEvent?.title ?? '';
    _rulesController.text = widget.vm.creatingEvent?.rules ?? '';
    allowTeams = widget.vm.creatingEvent?.teamsEnabled ?? false;
    allowMembersOnly = widget.vm.creatingEvent?.membersOnly ?? false;
    widget.vm.creatingEvent?.classes?.forEach((element) {
      var name = TextEditingController();
      var value = TextEditingController();
      name.text = element?.name ?? '';
      value.text = element?.maxEntries.toString() ?? "";
      classesModel.add(ClassesModel(name: name.text));
      classesControllers.add(Pair(name, value));
    });
    widget.vm.creatingEvent?.settings?.forEach((element) {
      var name = TextEditingController();
      var value = TextEditingController();
      name.text = element?.name ?? '';
      value.text = element?.value ?? '';
      settingsModel.add(SettingsModel(name: name.text, value: value.text));
      settingsControllers.add(Pair(name, value));
    });
    bannerFile = widget.vm.bannerFile ?? File('');
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        state: widget.vm.state,
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
          const TextWidget(text: "Championship", style: Style.title),
          steps()
        ],
      ),
    );
  }

  Widget steps() {
    return StepperWidget(
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
          title: const Text('Options'),
          content: options(),
        ),
        Step(
          title: const Text('Tags'),
          content: tag(),
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
      append: finish(),
    );
  }

  Widget basic() {
    return Column(
      children: [
        InputTextWidget(
            enabled: true,
            label: "Title",
            icon: Icons.title,
            controller: _titleController,
            validator: (value) {}),
        const SpacingWidget(LayoutSize.size16),
        InputTextWidget(
            enabled: true,
            label: "Rules",
            icon: Icons.title,
            controller: _rulesController,
            validator: (value) {},
            inputType: InputType.multilines),
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
                text: "Allow racing teams", style: Style.paragraph)
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
                text: "Allow members only", style: Style.paragraph)
          ],
        )
      ],
    );
  }

  Widget scoring() {
    return ScoringWidget(
      editing: true,
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
          itemCount: settingsModel.length,
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
                          settingsModel.removeAt(index);
                          settingsControllers.removeAt(index);
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
            type: ButtonType.iconButton,
            icon: Icons.add,
            onPressed: () async {
              setState(() {
                var name = TextEditingController();
                var value = TextEditingController();
                settingsModel
                    .add(SettingsModel(name: name.text, value: value.text));
                settingsControllers.add(Pair(name, value));
              });
            },
            label: 'Create setting'),
      ],
    );
  }

  Widget tag() {
    return widget.vm.tags!.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.zero,
            child: Wrap(
              children: widget.vm.tags!
                  .map((item) {
                    final selected = tags.contains(item?.id);
                    return ActionChip(
                        avatar: CircleAvatar(
                          backgroundColor: selected
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                          child: selected ? const Text('-') : const Text('+'),
                        ),
                        label: Text(item?.name ?? ''),
                        onPressed: () {
                          setState(() {
                            selected
                                ? tags.remove(item?.id)
                                : tags.add(item?.id);
                          });
                        });
                  })
                  .toList()
                  .cast<Widget>(),
            ),
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
                          controller: classesControllers[index].first,
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
                        controller: classesControllers[index].second,
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
                      type: ButtonType.iconButton,
                      icon: Icons.delete,
                      onPressed: () {
                        setState(() {
                          classesModel.removeAt(index);
                          classesControllers.removeAt(index);
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
            type: ButtonType.iconButton,
            icon: Icons.add,
            onPressed: () async {
              setState(() {
                var name = TextEditingController();
                var value = TextEditingController();
                classesModel.add(ClassesModel(name: name.text));
                classesControllers.add(Pair(name, value));
              });
            },
            label: 'Create class'),
      ],
    );
  }

  Widget finish() {
    return ButtonWidget(
      enabled: _formKey.currentState?.validate() == true,
      type: ButtonType.primary,
      onPressed: () {
        for (var i = 0; i < settingsModel.length; i++) {
          settingsModel[i]?.name = settingsControllers[i].first?.text;
          settingsModel[i]?.value = settingsControllers[i].second?.text;
        }
        for (var i = 0; i < classesModel.length; i++) {
          classesModel[i]?.name = classesControllers[i].first?.text;
          classesModel[i]?.maxEntries =
              int.parse(classesControllers[i].second?.text ?? '');
        }

        var event = EventModel(
            races: [],
            tags: tags,
            settings: settingsModel,
            classes: classesModel,
            teamsEnabled: allowTeams,
            membersOnly: allowMembersOnly,
            title: _titleController.text,
            rules: _rulesController.text,
            scoring: score);
        List<int> bannerBytes = [];
        try {
          bannerBytes = bannerFile.readAsBytesSync();
        } catch (e) {}
        String bannerImage = base64Encode(bannerBytes);
        var media = MediaModel(bannerImage);
        widget.vm.createChampionshipEventStep(event, media, bannerFile);
      },
      label: "Next",
    );
  }
}
