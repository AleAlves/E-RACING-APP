import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/model/session_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_races_session_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/presentation/ui/model/championship_races_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventManagementEditRaceWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventManagementEditRaceWidget(this.viewModel, {Key? key})
      : super(key: key);

  @override
  _EventManagementEditRaceWidgetState createState() =>
      _EventManagementEditRaceWidgetState();
}

class _EventManagementEditRaceWidgetState
    extends State<EventManagementEditRaceWidget> implements BaseSateWidget {
  int _stepIndex = 0;
  bool _editingImage = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  ChampionshipRacesModel? model;
  List<SessionModel>? sessions;

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
    var race = widget.viewModel.event?.races
        ?.firstWhere((element) => element?.id == Session.instance.getRaceId());
    titleController.text = race?.title ?? '';
    linkController.text = race?.broadcastLink ?? '';

    model = ChampionshipRacesModel(
        eventDate: toDatetime(race?.date),
        poster: race?.poster,
        hasBroadcasting: false,
        picker: ImagePicker(),
        posterFile: File(''),
        titleController: titleController,
        broadcastingLinkController: linkController,
        sessions: race?.sessions,
        id: race?.id);
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
    widget.viewModel.setFlow(EventFlow.manager);
    return false;
  }

  @override
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
          const SpacingWidget(LayoutSize.size48),
          const TextWidget(text: "Race", style: Style.title),
          const SpacingWidget(LayoutSize.size48),
          Stepper(
            physics: const ClampingScrollPhysics(),
            currentStep: _stepIndex,
            onStepTapped: (int index) {
              setState(() {
                _stepIndex = index;
              });
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
                content: posterWidget(),
              ),
              Step(
                title: const Text('Sessions'),
                content: sessionsWidget(),
              ),
              Step(
                title: const Text('Broadcast'),
                content: broadcasting(),
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size48),
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
            controller: titleController,
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

  Widget posterWidget() {
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
                child: _editingImage
                    ? Image.file(model?.posterFile ?? File(''))
                    : Image.memory(base64Decode(model?.poster.toString() ?? '')),
              ),
            ),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconButton,
                icon: Icons.image_search,
                onPressed: () async {
                  var image = await model?.picker
                      ?.pickImage(source: ImageSource.gallery);
                  model?.posterFile = File(image?.path ?? '');
                  _editingImage = true;
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
            text:
                "${formatHour(model?.eventDate?.toIso8601String())} - ${formatDate(model?.eventDate?.toIso8601String())}",
            style: Style.subtitle),
        const SpacingWidget(LayoutSize.size32),
        ButtonWidget(
            icon: Icons.date_range,
            enabled: true,
            type: ButtonType.iconButton,
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: false,
                  minTime: toDatetime(model?.eventDate?.toIso8601String()),
                  onChanged: (date) {
                setState(() {
                  model?.eventDate = date;
                });
              }, currentTime: DateTime.now());
            }),
      ],
    );
  }

  Widget sessionsWidget() {
    return EventCreateRaceSessionWidget(
      model: model,
    );
  }

  Widget broadcasting() {
    return Column(
      children: [
        const TextWidget(text: "Settings", style: Style.description),
        Row(
          children: [
            Checkbox(
              value: model?.hasBroadcasting,
              onChanged: (bool? value) {
                setState(() {
                  model?.hasBroadcasting = value ?? false;
                });
              },
            ),
            const TextWidget(
                text: "Live broadcasting", style: Style.description),
          ],
        ),
        if (model?.hasBroadcasting == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InputTextWidget(
                    enabled: true,
                    label: "link",
                    icon: Icons.settings,
                    controller: TextEditingController(),
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
                    type: ButtonType.iconButton,
                    onPressed: () async {
                      Clipboard.getData(Clipboard.kTextPlain).then((value) {});
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
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.updateRace(model);
      },
      label: "Update",
    );
  }
}
