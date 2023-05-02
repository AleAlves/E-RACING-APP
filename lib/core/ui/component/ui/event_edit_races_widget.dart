import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../event/core/presentation/ui/model/session_race_model.dart';
import 'event_races_session_widget.dart';

class EventEditRacesWidget extends StatefulWidget {
  final EventRaceModel model;

  const EventEditRacesWidget(this.model, {Key? key}) : super(key: key);

  @override
  _EventEditRacesWidgetState createState() => _EventEditRacesWidgetState();
}

class _EventEditRacesWidgetState extends State<EventEditRacesWidget> {
  int _stepIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _linkController = TextEditingController();

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
                content: banner(),
              ),
              Step(
                title: const Text('Sessions'),
                content: sessions(),
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

  Widget banner() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(4.0),
            //   child: SizedBox(
            //     height: 300,
            //     width: MediaQuery.of(context).size.height,
            //     child: widget.model.posterFile?.path == ''
            //         ? Container()
            //         : Image.file(
            //             widget.model.posterFile ?? File(''),
            //             fit: BoxFit.fill,
            //           ),
            //   ),
            // ),
            // ButtonWidget(
            //     enabled: true,
            //     type: ButtonType.iconButton,
            //     icon: Icons.image_search,
            //     onPressed: () async {
            //       var image = await widget.model.picker
            //           ?.pickImage(source: ImageSource.gallery);
            //       setState(() {
            //         widget.model.posterFile = File(image?.path ?? '');
            //       });
            //     })
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWidget(text: "${widget.model.eventDate}", style: Style.subtitle),
        const SpacingWidget(LayoutSize.size32),
        ButtonWidget(
            icon: Icons.date_range,
            enabled: true,
            type: ButtonType.iconButton,
            onPressed: () {
              _callDatePicker();
            }),
      ],
    );
  }

  _callDatePicker() async {
    var date = await getDate();
    setState(() {
      widget.model.eventDate = date?.toIso8601String();
    });
  }

  Future<DateTime?> getDate() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2099));
  }

  Widget sessions() {
    return EventCreateRaceSessionWidget(
      sessionModel: widget.model,
    );
  }

  Widget broadcasting() {
    return Column(
      children: [
        const TextWidget(text: "Settings", style: Style.paragraph),
        Row(
          children: [
            Checkbox(
              value: widget.model.hasBroadcasting,
              onChanged: (bool? value) {
                setState(() {
                  widget.model.hasBroadcasting = value ?? false;
                });
              },
            ),
            const TextWidget(text: "Live broadcasting", style: Style.paragraph),
          ],
        ),
        if (widget.model.hasBroadcasting == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InputTextWidget(
                    enabled: true,
                    label: "link",
                    icon: Icons.settings,
                    controller: _linkController,
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
                        _linkController.text =
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
