import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/stepper_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/ext/dialog_extension.dart';
import '../../../../core/model/race_model.dart';
import '../../../../core/ui/component/ui/card_widget.dart';
import '../../../../core/ui/component/ui/float_action_button_widget.dart';
import '../../../../core/ui/component/ui/icon_widget.dart';
import '../../../../core/ui/component/ui/scoring_widget.dart';
import '../event_update_view_model.dart';

class EventUpdateView extends StatefulWidget {
  final EventUpdateViewModel viewModel;

  const EventUpdateView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventUpdateViewState createState() => _EventUpdateViewState();
}

class _EventUpdateViewState extends State<EventUpdateView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    observers();
    super.initState();
    if (widget.viewModel.event == null) {
      widget.viewModel.getEvent();
    }
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
  observers() async {
    widget.viewModel.titleController.addListener(() {
      widget.viewModel.event?.title = widget.viewModel.titleController.text;
    });
    widget.viewModel.rulesController.addListener(() {
      widget.viewModel.event?.rules = widget.viewModel.rulesController.text;
    });
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
        floatAction: deleteAction(),
        bottom: buttonWidget(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }

  FloatActionButtonWidget deleteAction() {
    return FloatActionButtonWidget(
      icon: Icons.delete_forever,
      title: "Delete",
      onPressed: () {
        confirmationDialogExt(
            context: context,
            onPositive: () {},
            consentMessage: "Yes, I do",
            issueMessage: "Do you want to delete this event?");
      },
    );
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
        children: [
          TextWidget(
              text: widget.viewModel.event?.title, style: Style.paragraph),
          stepper(),
          const SpacingWidget(LayoutSize.size64),
        ],
      ),
    );
  }

  Widget stepper() {
    return SizedBox(
      child: StepperWidget(
        steps: [
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
          Step(
            title: const Text('Races'),
            content: races(),
          ),
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
            controller: widget.viewModel.titleController,
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
            controller: widget.viewModel.rulesController,
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
                child: widget.viewModel.bannerFile.path == ''
                    ? Image.memory(
                        base64Decode(widget.viewModel.banner?.image ?? ""),
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        widget.viewModel.bannerFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            ButtonWidget(
                enabled: true,
                type: ButtonType.icon,
                icon: Icons.image_search,
                onPressed: () async {
                  var image = await widget.viewModel.picker
                      .pickImage(source: ImageSource.gallery);
                  setState(() {
                    widget.viewModel.bannerFile = File(image?.path ?? '');
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
    return Column(
      children: [
        ScoringWidget(editing: true, scoring: widget.viewModel.event?.scoring),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconShapeless,
                icon: Icons.remove,
                onPressed: () {
                  setState(() {
                    widget.viewModel.event?.scoring?.removeLast();
                  });
                }),
            const SpacingWidget(LayoutSize.size48),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconShapeless,
                icon: Icons.add,
                onPressed: () {
                  setState(() {
                    widget.viewModel.event?.scoring?.add(0);
                  });
                }),
          ],
        ),
      ],
    );
  }

  Widget settings() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.viewModel.settingsEdit.length,
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
                          controller:
                              widget.viewModel.settingsEdit[index].first,
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
                          controller:
                              widget.viewModel.settingsEdit[index].second,
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
                      type: ButtonType.iconShapeless,
                      icon: Icons.delete,
                      onPressed: () {
                        setState(() {
                          widget.viewModel.event?.settings?.removeAt(index);
                          widget.viewModel.settingsEdit.removeAt(index);
                        });
                      }),
                )
              ],
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SpacingWidget(LayoutSize.size48),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconShapeless,
                icon: Icons.remove,
                onPressed: () {
                  setState(() {
                    widget.viewModel.event?.settings?.removeLast();
                    widget.viewModel.settingsEdit.removeLast();
                  });
                }),
            const SpacingWidget(LayoutSize.size48),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconShapeless,
                icon: Icons.add,
                onPressed: () {
                  setState(() {
                    widget.viewModel.settingsEdit.add(
                        Pair(TextEditingController(), TextEditingController()));
                    widget.viewModel.event?.settings
                        ?.add(SettingsModel(name: "", value: ""));
                  });
                }),
          ],
        ),
      ],
    );
  }

  Widget classes() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.viewModel.classesEdit.length,
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
                          controller: widget.viewModel.classesEdit[index].first,
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
                        controller: widget.viewModel.classesEdit[index].second,
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
                      type: ButtonType.iconShapeless,
                      icon: Icons.delete,
                      onPressed: () {
                        setState(() {
                          widget.viewModel.event?.classes?.removeAt(index);
                          widget.viewModel.classesEdit.removeAt(index);
                        });
                      }),
                )
              ],
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SpacingWidget(LayoutSize.size48),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconShapeless,
                icon: Icons.remove,
                onPressed: () {
                  setState(() {
                    widget.viewModel.classesEdit.removeLast();
                    widget.viewModel.event?.classes?.removeLast();
                  });
                }),
            const SpacingWidget(LayoutSize.size48),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconShapeless,
                icon: Icons.add,
                onPressed: () {
                  setState(() {
                    widget.viewModel.classesEdit.add(
                        Pair(TextEditingController(), TextEditingController()));
                    widget.viewModel.event?.classes
                        ?.add(ClassesModel(name: "", maxEntries: 0));
                  });
                }),
          ],
        ),
      ],
    );
  }

  Widget races() {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.viewModel.event?.races?.length,
      itemBuilder: (context, index) {
        return raceCard(widget.viewModel.event?.races?[index]);
      },
    );
  }

  Widget raceCard(RaceModel? raceModel) {
    return CardWidget(
      onPressed: () {
        widget.viewModel.goToRaceDetail(raceModel);
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
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            TextWidget(
                                text: raceModel?.title, style: Style.caption),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const IconWidget(
                icon: Icons.edit,
                borderless: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: _formKey.currentState?.validate() == true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.updateEvent();
      },
      label: "Update",
    );
  }
}
