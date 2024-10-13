import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/event_races_session_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../../../core/data/session_race_model.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateRaceView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateRaceView(this.viewModel, {super.key});

  @override
  EventCreateRaceViewState createState() => EventCreateRaceViewState();
}

class EventCreateRaceViewState extends State<EventCreateRaceView>
    implements BaseSateWidget {
  int _stepIndex = 0;
  var isValid = false;
  final _titleController = TextEditingController();
  final _broadcastLinkController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File posterFile = File('');
  DateTime? eventDate = DateTime.now();
  EventRaceModel? raceModel;

  @override
  void initState() {
    observers();
    super.initState();
    raceModel = EventRaceModel(
        title: _titleController.text,
        hasBroadcasting: false,
        broadcastLink: _broadcastLinkController.text,
        eventDate: eventDate?.toIso8601String(),
        sessions: []);
    if (widget.viewModel.editingRaceModel != null) {
      setState(() {
        _titleController.text =
            widget.viewModel.editingRaceModel?.title.toString() ?? "";
        raceModel?.hasBroadcasting =
            widget.viewModel.editingRaceModel?.hasBroadcasting;
        raceModel?.poster = widget.viewModel.editingRaceModel?.poster;
        _broadcastLinkController.text =
            widget.viewModel.editingRaceModel?.broadcastLink ?? "";
        raceModel?.sessions = widget.viewModel.editingRaceModel?.sessions;
      });
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
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: buttonWidget(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(EventCreateNavigator.eventRaceList);
    return false;
  }

  @override
  observers() {
    _titleController.addListener(() {
      final String text = _titleController.text;
      raceModel?.title = text;
      setState(() {
        isValid = text.isNotEmpty;
      });
    });

    _broadcastLinkController.addListener(() {
      final String text = _broadcastLinkController.text;
      raceModel?.broadcastLink = text;
    });
  }

  @override
  Widget content() {
    return stepper();
  }

  Widget stepper() {
    return Stepper(
      physics: const ClampingScrollPhysics(),
      controlsBuilder: (context, _) {
        return Row(
          children: <Widget>[
            Container(),
            Container(),
          ],
        );
      },
      currentStep: _stepIndex,
      onStepTapped: (int index) {
        setState(() {
          _stepIndex = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Title'),
          content: basic(),
        ),
        Step(
          title: const Text('Poster'),
          content: posterBanner(),
        ),
        Step(
          title: const Text('Date'),
          content: date(context),
        ),
        Step(
          title: const Text('Sessions'),
          content: sessions(),
        ),
        Step(
          title: const Text('Broadcasting'),
          content: broadcasting(),
        ),
      ],
    );
  }

  Widget basic() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size32),
        InputTextWidget(
            enabled: true,
            label: "Race Title",
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

  Widget date(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWidget(
            text: "${eventDate?.hour}:${eventDate?.minute}, "
                "${eventDate?.day}/${eventDate?.month}/${eventDate?.year} ",
            style: Style.subtitle),
        const SpacingWidget(LayoutSize.size32),
        ButtonWidget(
            icon: Icons.date_range,
            enabled: true,
            type: ButtonType.icon,
            onPressed: () {
              _callDatePicker();
              // DatePicker.showDateTimePicker(context,
              //     showTitleActions: false,
              //     minTime: DateTime.now(), onChanged: (date) {
              //   setState(() {
              //     eventDate = date;
              //   });
              // }, currentTime: DateTime.now());
            }),
      ],
    );
  }

  _callDatePicker() async {
    var date = await getDate();
    setState(() {
      eventDate = date;
    });
  }

  Future<DateTime?> getDate() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2099));
  }

  Widget posterBanner() {
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
                    ? widget.viewModel.editingRaceModel?.poster == null
                        ? Container()
                        : Image.memory(
                            base64Decode(
                                widget.viewModel.editingRaceModel?.poster ??
                                    ''),
                            fit: BoxFit.fill,
                          )
                    : Image.file(
                        posterFile,
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
                    posterFile = File(image?.path ?? '');
                    raceModel?.poster =
                        base64Encode(posterFile.readAsBytesSync());
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

  Widget sessions() {
    return EventCreateRaceSessionWidget(
      sessionModel: raceModel,
    );
  }

  Widget broadcasting() {
    return Column(
      children: [
        const TextWidget(text: "Settings", style: Style.paragraph),
        Row(
          children: [
            Checkbox(
              value: raceModel?.hasBroadcasting == true,
              onChanged: (bool? value) {
                setState(() {
                  raceModel?.hasBroadcasting = value ?? false;
                });
              },
            ),
            const TextWidget(text: "Live broadcasting", style: Style.paragraph),
          ],
        ),
        if (raceModel?.hasBroadcasting == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InputTextWidget(
                    enabled: true,
                    label: "link",
                    icon: Icons.settings,
                    controller: _broadcastLinkController,
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
                        _broadcastLinkController.text =
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

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        if (widget.viewModel.editingRaceModel == null) {
          widget.viewModel.addRace(raceModel);
        } else {
          widget.viewModel.updateRace(raceModel);
        }
      },
      label: widget.viewModel.editingRaceModel == null ? "Create" : "Update",
    );
  }
}
