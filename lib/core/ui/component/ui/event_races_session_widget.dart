import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/session_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/event/presentation/ui/model/championship_races_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'button_widget.dart';
import 'spacing_widget.dart';
import 'class_collection_widget.dart';

class EventCreateRaceSessionWidget extends StatefulWidget {
  final ChampionshipRacesModel model;

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
          itemCount: widget.model.sessions?.length,
          itemBuilder: (context, index) {
            return CardWidget(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: getSessionType(
                              widget.model.sessions?[index].type),
                          style: Style.subtitle,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonWidget(
                              enabled: true,
                              type: ButtonType.iconBorderless,
                              icon: Icons.delete,
                              onPressed: () {
                                setState(() {
                                  widget.model.sessions?.removeAt(index);
                                });
                              }),
                        )
                      ],
                    ),
                    if (widget.model.sessions?[index] == null ||
                        widget.model.sessions?[index].settings == null ||
                        widget.model.sessions?[index].settings?.isEmpty == true)
                      Container()
                    else
                      Wrap(
                        direction: Axis.vertical,
                        children: widget.model.sessions![index].settings!
                            .map((item) {
                              return TextWidget(
                                  text: "${item?.name}: ${item?.value}",
                                  style: Style.description);
                            })
                            .toList()
                            .cast<Widget>(),
                      ),
                    const SpacingWidget(LayoutSize.size16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(
                            enabled: true,
                            type: ButtonType.iconBorderless,
                            icon: Icons.add,
                            label: "new setting",
                            onPressed: () async {
                              newSettings(index);
                            }),
                        const SpacingWidget(LayoutSize.size24),
                        if (widget.model.sessions?[index] == null ||
                            widget.model.sessions?[index].settings == null ||
                            widget.model.sessions?[index].settings?.isEmpty == true)
                          Container()
                        else
                          ButtonWidget(
                              enabled: true,
                              type: ButtonType.iconBorderless,
                              icon: Icons.delete,
                              label: "Delete",
                              onPressed: () async {
                                setState(() {
                                  widget.model.sessions?[index].settings?.removeLast();
                                });
                              }),
                      ],
                    ),
                  ],
                ),
                ready: true);
          },
        ),
        const SpacingWidget(LayoutSize.size16),
        ButtonWidget(
            enabled: true,
            type: ButtonType.borderless,
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
                                  type: ButtonType.icon,
                                  icon: Icons.done,
                                  onPressed: () {
                                    setState(() {
                                      widget.model.sessions?.add(session);
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
                  const TextWidget(text: "Setting", style: Style.description),
                  const SpacingWidget(LayoutSize.size16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            InputTextWidget(
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
                        type: ButtonType.icon,
                        icon: Icons.done,
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            setState(() {
                              widget.model.sessions?[index].settings?.add(
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

  String getSessionType(SessionType? type) {
    switch (type) {
      case SessionType.warmup:
        return "Warmup";
      case SessionType.practice:
        return "Practice";
      case SessionType.qualify:
        return "Qualify";
      case SessionType.race:
        return "Race";
      default:
        return "Unknow";
    }
  }
}
