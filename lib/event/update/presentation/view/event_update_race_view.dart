import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/session_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/ui/component/ui/race_edit_session_widget.dart';
import '../../../../core/ui/component/ui/stepper_widget.dart';
import '../event_update_view_model.dart';
import '../router/event_update_router.dart';

class EventUpdateRaceView extends StatefulWidget {
  final EventUpdateViewModel viewModel;

  const EventUpdateRaceView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventUpdateRaceViewState createState() => _EventUpdateRaceViewState();
}

class _EventUpdateRaceViewState extends State<EventUpdateRaceView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  RaceModel? model;
  List<SessionModel>? sessions;
  final ImagePicker _picker = ImagePicker();
  bool hasBroadcasting = false;

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
    hasBroadcasting = race?.broadcasting ?? false;
    model = RaceModel(
        date: toDatetime(race?.date).toIso8601String(),
        poster: race?.poster,
        broadcasting: race?.broadcasting,
        broadcastLink: race?.broadcastLink,
        title: titleController.text,
        sessions: race?.sessions,
        id: race?.id,
        finished: race?.finished,
        canceled: race?.canceled);

    titleController.addListener(() {
      model?.title = titleController.text;
    });
    linkController.addListener(() {
      model?.broadcastLink = linkController.text;
    });
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
        bottom: finishButton(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(EventUpdateRouter.main);
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
          StepperWidget(
            steps: [
              Step(
                title: const Text('Title'),
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
                child:
                    Image.memory(base64Decode(model?.poster.toString() ?? '')),
              ),
            ),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconButton,
                icon: Icons.image_search,
                onPressed: () async {
                  var im = await _picker.pickImage(source: ImageSource.gallery);
                  var base64Poster = File(im?.path ?? '');
                  setState(() {
                    model?.poster =
                        base64Encode(base64Poster.readAsBytesSync());
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

  Widget date() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
            text: "${formatHour(model?.date)} - ${formatDate(model?.date)}",
            style: Style.subtitle),
        const SpacingWidget(LayoutSize.size32),
        ButtonWidget(
            icon: Icons.date_range,
            enabled: true,
            type: ButtonType.iconButton,
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: false,
                  minTime: toDatetime(model?.date), onChanged: (date) {
                setState(() {
                  model?.date = date.toIso8601String();
                });
              }, currentTime: DateTime.now());
            }),
      ],
    );
  }

  Widget sessionsWidget() {
    return EventEditRaceSessionWidget(
      sessionModel: model,
    );
  }

  Widget broadcasting() {
    return Column(
      children: [
        const TextWidget(text: "Settings", style: Style.paragraph),
        Row(
          children: [
            Checkbox(
              value: model?.broadcasting,
              onChanged: (bool? value) {
                setState(() {
                  model?.broadcasting = value ?? false;
                });
              },
            ),
            const TextWidget(text: "Live broadcasting", style: Style.paragraph),
          ],
        ),
        if (model?.broadcasting == true)
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

  Widget finishButton() {
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
