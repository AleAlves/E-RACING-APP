import 'dart:io';

import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/event_races_session_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../../../presentation/ui/model/championship_races_model.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateRaceView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateRaceView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateRaceViewState createState() => _EventCreateRaceViewState();
}

class _EventCreateRaceViewState extends State<EventCreateRaceView>
    implements BaseSateWidget {
  int _stepIndex = 0;
  var isValid = false;
  final _titleController = TextEditingController();
  final _broadcastLinkController = TextEditingController();
  File posterFile = File('');
  final ImagePicker _picker = ImagePicker();
  DateTime? eventDate = DateTime.now();
  bool? hasBroadcasting = false;
  ChampionshipRacesModel? model;

  @override
  void initState() {
    observers();
    model = ChampionshipRacesModel(
      hasBroadcasting: hasBroadcasting,
      eventDate: eventDate,
      sessions: [],
      picker: _picker,
      posterFile: posterFile,
      titleController: _titleController,
      broadcastingLinkController: _broadcastLinkController,
      poster: null,
      id: null,
    );
    super.initState();
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
    widget.viewModel.onNavigate(EventCreateNavigator.racesList);
    return false;
  }

  @override
  observers() {
    _titleController.addListener(() {
      final String text = _titleController.text;
      setState(() {
        isValid = text.isNotEmpty;
      });
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
          content: banner(),
        ),
        Step(
          title: const Text('Date'),
          content: date(),
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

  Widget date() {
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
            type: ButtonType.iconButton,
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
                    ? Container()
                    : Image.file(
                        posterFile,
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
                    posterFile = File(image?.path ?? '');
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
      model: model,
    );
  }

  Widget broadcasting() {
    return Column(
      children: [
        const TextWidget(text: "Settings", style: Style.paragraph),
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
            const TextWidget(text: "Live broadcasting", style: Style.paragraph),
          ],
        ),
        if (hasBroadcasting == true)
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
                    type: ButtonType.iconButton,
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
        widget.viewModel.addRace(model);
      },
      label: "Add Race",
    );
  }
}
