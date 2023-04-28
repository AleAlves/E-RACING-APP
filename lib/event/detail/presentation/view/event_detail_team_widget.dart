import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/detail/presentation/router/event_detail_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/ui/stepper_widget.dart';
import '../event_detail_view_model.dart';

class EventDetailTeamWidget extends StatefulWidget {
  final EventDetailViewModel viewModel;

  const EventDetailTeamWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventDetailTeamWidgetState createState() => _EventDetailTeamWidgetState();
}

class _EventDetailTeamWidgetState extends State<EventDetailTeamWidget>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  List<String?> drivers = [];

  @override
  void initState() {
    super.initState();
    widget.viewModel.state = ViewState.ready;
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          child: createForm(),
          key: _formKey,
        ),
      ],
    );
  }

  @override
  observers() {}

  Widget createForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(text: "Team", style: Style.title),
          stepper(),
          const SpacingWidget(LayoutSize.size48),
        ],
      ),
    );
  }

  Widget stepper() {
    return SizedBox(
      child: Column(
        children: [
          StepperWidget(
            steps: <Step>[
              Step(
                title: const Text('Name'),
                content: basic(),
              ),
              Step(
                title: const Text('Crew'),
                content: crew(),
              ),
            ],
            append: finish(),
          ),
        ],
      ),
    );
  }

  Widget basic() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          InputTextWidget(
              enabled: true,
              label: 'Name',
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'required';
                }
                return null;
              }),
        ],
      ),
    );
  }

  Widget crew() {
    return Column(
      children: [
        ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const IconWidget(icon: Icons.sports_motorsports),
                          TextWidget(
                            text: "${index + 1}# driver",
                            style: Style.subtitle,
                          )
                        ],
                      ),
                      const SpacingWidget(LayoutSize.size16),
                      TextWidget(
                        text: getName(drivers[index]),
                        style: Style.subtitle,
                      ),
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
                          drivers.removeAt(index);
                        });
                      }),
                ),
              ],
            );
          },
        ),
        const SpacingWidget(LayoutSize.size24),
        addButton()
      ],
    );
  }

  Widget addButton() {
    var max = widget.viewModel.event?.teamsMaxCrew?.toInt() ?? 2;
    if (drivers.length < max) {
      return ButtonWidget(
        enabled: true,
        type: ButtonType.iconButton,
        icon: Icons.add,
        label: "Add driver",
        onPressed: () {
          driverList();
        },
      );
    } else {
      return Container();
    }
  }

  Widget finish() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.important,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          widget.viewModel.createTeam(_nameController.text, drivers);
        }
      },
      label: "Create",
    );
  }

  driverList() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.viewModel.event?.classes?.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SpacingWidget(LayoutSize.size24),
                TextWidget(
                  text: widget.viewModel.event?.classes?[index]?.name ?? '',
                  style: Style.subtitle,
                ),
                const SpacingWidget(LayoutSize.size24),
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      widget.viewModel.event?.classes?[index]?.drivers?.length,
                  itemBuilder: (context, attendersIndex) {
                    return CardWidget(
                      ready: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SpacingWidget(LayoutSize.size16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextWidget(
                                    text: getName(widget
                                        .viewModel
                                        .event
                                        ?.classes?[index]
                                        ?.drivers?[attendersIndex]
                                        ?.driverId),
                                    style: Style.subtitle,
                                  ),
                                ),
                                ButtonWidget(
                                  enabled: true,
                                  type: ButtonType.iconButton,
                                  icon: Icons.add,
                                  onPressed: () {
                                    setState(() {
                                      drivers.add(widget
                                          .viewModel
                                          .event
                                          ?.classes?[index]
                                          ?.drivers?[attendersIndex]
                                          ?.driverId);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(EventDetailRouter.info);
    return false;
  }

  String getName(String? id) {
    var user = widget.viewModel.users
        ?.firstWhere((element) => element?.id == id)
        ?.profile;
    return "${user?.name} ${user?.surname}";
  }
}
