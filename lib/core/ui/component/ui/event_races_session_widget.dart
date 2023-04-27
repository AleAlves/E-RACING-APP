import 'package:e_racing_app/core/ext/status_extensions.dart';
import 'package:e_racing_app/core/model/session_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../event/core/presentation/ui/model/championship_races_model.dart';
import 'button_widget.dart';
import 'spacing_widget.dart';

class EventCreateRaceSessionWidget extends StatefulWidget {
  final ChampionshipRacesModel? model;

  const EventCreateRaceSessionWidget({required this.model, Key? key})
      : super(key: key);

  @override
  _EventCreateRaceSessionWidgetState createState() =>
      _EventCreateRaceSessionWidgetState();
}

class _EventCreateRaceSessionWidgetState
    extends State<EventCreateRaceSessionWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return content(context);
  }

  Widget content(BuildContext context) {
    return Form(
      child: sessions(),
      key: _formKey,
    );
  }

  Widget sessions() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.model?.sessions?.length,
          itemBuilder: (context, index) {
            return CardWidget(
                childLeft: Column(
                  children: [
                    ButtonWidget(
                        enabled: true,
                        type: ButtonType.iconBorderless,
                        icon: Icons.add,
                        onPressed: () async {
                          newSettings(index);
                        }),
                    const SpacingWidget(LayoutSize.size16),
                    ButtonWidget(
                        enabled: true,
                        type: ButtonType.iconBorderless,
                        icon: Icons.remove,
                        onPressed: () async {
                          setState(() {
                            widget.model!.sessions?[index]?.settings
                                ?.removeLast();
                          });
                        }),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: getSessionType(
                              widget.model?.sessions?[index]?.type),
                          style: Style.subtitle,
                        ),
                      ],
                    ),
                    if (widget.model?.sessions?[index] == null ||
                        widget.model?.sessions?[index]?.settings == null ||
                        widget.model?.sessions?[index]?.settings?.isEmpty ==
                            true)
                      Container()
                    else
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.spaceEvenly,
                        direction: Axis.vertical,
                        children: widget.model!.sessions![index]!.settings!
                            .map((session) {
                              return Column(
                                children: [
                                  const SpacingWidget(LayoutSize.size8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextWidget(
                                          text: "${session?.name}:",
                                          style: Style.paragraph),
                                      const SpacingWidget(LayoutSize.size8),
                                      TextWidget(
                                          text: "${session?.value}",
                                          style: Style.paragraph),
                                    ],
                                  ),
                                ],
                              );
                            })
                            .toList()
                            .cast<Widget>(),
                      ),
                    const SpacingWidget(LayoutSize.size16),
                  ],
                ),
                childRight: ButtonWidget(
                    enabled: true,
                    type: ButtonType.iconBorderless,
                    icon: Icons.delete,
                    onPressed: () {
                      setState(() {
                        widget.model?.sessions?.removeAt(index);
                      });
                    }),
                ready: true);
          },
        ),
        const SpacingWidget(LayoutSize.size16),
        ButtonWidget(
            enabled: true,
            type: ButtonType.link,
            icon: Icons.add,
            onPressed: () async {
              newSession();
            },
            label: 'New session'),
      ],
    );
  }

  newSession() {
    var session = SessionModel(type: SessionType.race, settings: []);
    SessionType? group = SessionType.race;
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CardWidget(
                        ready: true,
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Warmup'),
                              leading: Radio<SessionType>(
                                value: SessionType.warmup,
                                groupValue: group,
                                onChanged: (SessionType? value) {
                                  myState(() {
                                    group = value;
                                    session.type = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Practice'),
                              leading: Radio<SessionType>(
                                value: SessionType.practice,
                                groupValue: group,
                                onChanged: (SessionType? value) {
                                  myState(() {
                                    group = value;
                                    session.type = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Qualify'),
                              leading: Radio<SessionType>(
                                value: SessionType.qualify,
                                groupValue: group,
                                onChanged: (SessionType? value) {
                                  myState(() {
                                    group = value;
                                    session.type = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Race'),
                              leading: Radio<SessionType>(
                                value: SessionType.race,
                                groupValue: group,
                                onChanged: (SessionType? value) {
                                  myState(() {
                                    group = value;
                                    session.type = value;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ButtonWidget(
                                  enabled: true,
                                  type: ButtonType.iconButton,
                                  icon: Icons.done,
                                  onPressed: () {
                                    setState(() {
                                      widget.model!.sessions?.add(session);
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      Navigator.pop(context);
                                    });
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  newSettings(int index) {
    var nameController = TextEditingController();
    var valueController = TextEditingController();
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, modelState) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextWidget(text: "Setting", style: Style.paragraph),
                  const SpacingWidget(LayoutSize.size16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            InputTextWidget(
                                enabled: true,
                                label: "Name",
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                }),
                            const SpacingWidget(LayoutSize.size8),
                            InputTextWidget(
                                enabled: true,
                                label: "Value",
                                controller: valueController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SpacingWidget(LayoutSize.size16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonWidget(
                        enabled: true,
                        type: ButtonType.iconButton,
                        icon: Icons.done,
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            setState(() {
                              widget.model!.sessions?[index]?.settings?.add(
                                  SettingsModel(
                                      name: nameController.text,
                                      value: valueController.text));
                              Navigator.pop(context);
                            });
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
