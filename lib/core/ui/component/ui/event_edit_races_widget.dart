import 'dart:io';

import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/event/presentation/ui/model/championship_races_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../main.dart';

class EventEditRacesWidget extends StatefulWidget {
  final ChampionshipRacesModel model;

  const EventEditRacesWidget(this.model, {Key? key}) : super(key: key);

  @override
  _EventEditRacesWidgetState createState() => _EventEditRacesWidgetState();
}

class _EventEditRacesWidgetState extends State<EventEditRacesWidget> {
  int _index = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => content();

  Widget content() {
    return createForm();
  }

  Widget createForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [stepper()],
      ),
      key: _formKey,
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
    );
  }

  Widget basic() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size32),
        InputTextWidget(
            label: "Race Title",
            icon: Icons.title,
            controller: widget.model.titleController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Required';
              }
              return null;
            }),
        const SpacingWidget(LayoutSize.size32),
        InputTextWidget(
            label: "Notes",
            icon: Icons.title,
            controller: widget.model.notesController,
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
                child: widget.model.posterFile.path == ''
                    ? Container(
                        color: ERcaingApp.color.shade100,
                      )
                    : Image.file(
                        widget.model.posterFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            IconButtonWidget(Icons.image_search, () async {
              var image = await widget.model.picker.pickImage(source: ImageSource.gallery);
              setState(() {
                widget.model.posterFile = File(image?.path ?? '');
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

  Widget date() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWidget(
            text:
                "${widget.model.eventDate.hour}:${widget.model.eventDate.minute}, ${widget.model.eventDate.day}/${widget.model.eventDate.month}/${widget.model.eventDate.year} ",
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
                  widget.model.eventDate = date;
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
          itemCount: widget.model.settingsModel.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      InputTextWidget(
                          label: "Name",
                          icon: Icons.settings,
                          controller:
                              widget.model.settingsControllers[index].first,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            return null;
                          }),
                      const SpacingWidget(LayoutSize.size16),
                      InputTextWidget(
                          label: "Value",
                          icon: Icons.settings,
                          controller:
                              widget.model.settingsControllers[index].second,
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
                          widget.model.settingsModel.removeAt(index);
                          widget.model.settingsControllers.removeAt(index);
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
                widget.model.settingsModel.add(SettingsModel(name: name.text, value: value.text));
                widget.model.settingsControllers.add(
                    Pair(TextEditingController(), TextEditingController()));
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
              value: widget.model.hasBroadcasting,
              onChanged: (bool? value) {
                setState(() {
                  widget.model.hasBroadcasting = value ?? false;
                });
              },
            ),
            const TextWidget(
                text: "Live broadcasting", style: Style.description),
          ],
        ),
        if (widget.model.hasBroadcasting == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InputTextWidget(
                    label: "link",
                    icon: Icons.settings,
                    controller: widget.model.broadcastingLinkController,
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
                        widget.model.broadcastingLinkController.text =
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
}
