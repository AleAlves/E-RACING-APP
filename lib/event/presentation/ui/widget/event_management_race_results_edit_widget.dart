import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/model/entry_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/session_model.dart';
import 'package:e_racing_app/core/model/summary_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_races_session_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/data/race_standings_summary_model.dart';
import 'package:e_racing_app/event/data/set_summary_model.dart';
import 'package:e_racing_app/event/presentation/ui/model/championship_races_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventManagementEditRaceResultsWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventManagementEditRaceResultsWidget(this.viewModel, {Key? key})
      : super(key: key);

  @override
  _EventManagementEditRaceResultsWidgetState createState() =>
      _EventManagementEditRaceResultsWidgetState();
}

class _EventManagementEditRaceResultsWidgetState
    extends State<EventManagementEditRaceResultsWidget>
    implements BaseSateWidget {
  List<Pair<String, Color>> teamColors = [];
  bool performingInput = false;
  bool dnf = false;
  bool dqf = false;
  late TextEditingController positionController;
  late TextEditingController bonusController;
  late TextEditingController penaltyController;
  late TextEditingController fastestController;
  late TextEditingController notesController;

  @override
  void initState() {
    observers();
    widget.viewModel.getRaceStandings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

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
    widget.viewModel.setFlow(EventFlows.manager);
    return false;
  }

  @override
  Widget content() {
    return Column(
      children: [
        raceStatus(),
        const SpacingWidget(LayoutSize.size8),
        standings(),
        const SpacingWidget(LayoutSize.size8),
      ],
    );
  }

  Widget raceStatus() {
    return CardWidget(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const TextWidget(style: Style.subtitle, text: "Race status"),
              const SpacingWidget(LayoutSize.size48),
              ButtonWidget(
                enabled: true,
                type: ButtonType.normal,
                onPressed: () {
                  //widget.viewModel.updateRace(model);
                },
                label: "Canceled",
              ),
              const SpacingWidget(LayoutSize.size8),
              ButtonWidget(
                enabled: true,
                type: ButtonType.normal,
                onPressed: () {
                  //widget.viewModel.updateRace(model);
                },
                label: "Finish",
              ),
              const SpacingWidget(LayoutSize.size8),
            ],
          ),
        ),
        ready: true);
  }

  Widget standings() {
    if (widget.viewModel.raceStandings?.isEmpty == true) {
      return const Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: LoadingShimmer(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.viewModel.raceStandings?.length,
              itemBuilder: (context, index) {
                return CardWidget(
                  ready: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextWidget(style: Style.subtitle, text: "Results"),
                      const SpacingWidget(LayoutSize.size48),
                      TextWidget(
                          style: Style.subtitle,
                          text: widget.viewModel.raceStandings?[index]
                              ?.raceClass?.name),
                      const SpacingWidget(LayoutSize.size16),
                      drivers(index,
                          widget.viewModel.raceStandings?[index]?.standings)
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget driverCard(int classIndex, RaceStandingsSummaryModel? standing) {
    if (teamColors
            .where((element) => element.first == standing?.team?.id)
            .isEmpty ==
        true) {
      teamColors.add(Pair(standing?.team?.id, getTeamColor(teamColors.length)));
    }
    return CardWidget(
        onPressed: () {
          setState(() {
            showDriverSummary(classIndex, standing);
          });
        },
        padding: EdgeInsets.zero,
        shapeLess: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 5,
                      color: teamColors
                          .firstWhere(
                              (element) => element.first == standing?.team?.id)
                          .second,
                    ),
                    const SpacingWidget(LayoutSize.size16),
                    TextWidget(
                      text: "${standing?.summary?.position}º",
                      style: Style.subtitle,
                      align: TextAlign.start,
                    ),
                  ],
                ),
                const SpacingWidget(LayoutSize.size8),
                CountryCodePicker(
                  onChanged: print,
                  showCountryOnly: true,
                  enabled: false,
                  initialSelection: standing?.user?.profile?.country,
                  hideMainText: true,
                  showFlagMain: true,
                  showFlag: false,
                ),
                const SpacingWidget(LayoutSize.size8),
                Expanded(
                  child: Wrap(
                    children: [
                      TextWidget(
                        text:
                            "${standing?.user?.profile?.name?[0]}. ${standing?.user?.profile?.surname}",
                        style: Style.subtitle,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    TextWidget(
                      text: "${standing?.summary?.points} pts",
                      style: Style.subtitle,
                      align: TextAlign.start,
                    ),
                  ],
                ),
                const SpacingWidget(LayoutSize.size16),
                Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )
              ],
            ),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                height: 1)
          ],
        ),
        ready: true);
  }

  Widget drivers(int classIndex, List<RaceStandingsSummaryModel>? standings) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: standings?.length,
      itemBuilder: (context, index) {
        return driverCard(classIndex, standings?[index]);
      },
    );
  }

  showDriverSummary(int classIndex, RaceStandingsSummaryModel? standing) {
    setup();
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return SizedBox(
                child: Wrap(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: performingInput
                            ? const LoadingRipple()
                            : CardWidget(
                                ready: true,
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.sports_motorsports),
                                        const SpacingWidget(LayoutSize.size8),
                                        TextWidget(
                                          text:
                                              "${standing?.user?.profile?.name} ${standing?.user?.profile?.surname}",
                                          style: Style.subtitle,
                                          align: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    const SpacingWidget(LayoutSize.size8),
                                    if (standing?.team == null)
                                      Container()
                                    else
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.group,
                                            color: teamColors
                                                .firstWhere((element) =>
                                                    element.first ==
                                                    standing?.team?.id)
                                                .second,
                                          ),
                                          const SpacingWidget(LayoutSize.size8),
                                          TextWidget(
                                            text: "${standing?.team?.name}",
                                            style: Style.subtitle,
                                            align: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    const SpacingWidget(LayoutSize.size16),
                                    InputTextWidget(
                                        enabled: !performingInput,
                                        inputType: InputType.number,
                                        label: "Position",
                                        controller: positionController,
                                        validator: (value) {}),
                                    const SpacingWidget(LayoutSize.size16),
                                    InputTextWidget(
                                        enabled: !performingInput,
                                        inputType: InputType.number,
                                        label: "Bonus points",
                                        controller: bonusController,
                                        validator: (value) {}),
                                    const SpacingWidget(LayoutSize.size16),
                                    InputTextWidget(
                                        enabled: !performingInput,
                                        inputType: InputType.number,
                                        label: "Penalty points",
                                        controller: penaltyController,
                                        validator: (value) {}),
                                    const SpacingWidget(LayoutSize.size16),
                                    InputTextWidget(
                                        enabled: !performingInput,
                                        inputType: InputType.number,
                                        label: "Fastest Lap time",
                                        controller: fastestController,
                                        validator: (value) {}),
                                    const SpacingWidget(LayoutSize.size16),
                                    InputTextWidget(
                                        enabled: !performingInput,
                                        inputType: InputType.multilines,
                                        label: "Notes",
                                        controller: notesController,
                                        validator: (value) {}),
                                    const SpacingWidget(LayoutSize.size16),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: dnf,
                                          onChanged: (bool? value) {
                                            if (!performingInput) {
                                              myState(() {
                                                dnf = value ?? false;
                                              });
                                            }
                                          },
                                        ),
                                        const TextWidget(
                                            text: "Didn't finish the race",
                                            style: Style.description)
                                      ],
                                    ),
                                    const SpacingWidget(LayoutSize.size8),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: dqf,
                                          onChanged: (bool? value) {
                                            if (!performingInput) {
                                              myState(() {
                                                dqf = value ?? false;
                                              });
                                            }
                                          },
                                        ),
                                        const TextWidget(
                                            text: "Desqualified",
                                            style: Style.description)
                                      ],
                                    ),
                                    const SpacingWidget(LayoutSize.size48),
                                    ButtonWidget(
                                      enabled: true,
                                      type: ButtonType.icon,
                                      icon: Icons.archive,
                                      onPressed: () {
                                        myState(() {
                                          performingInput = true;
                                          widget.viewModel.setSummaryResult(
                                              SetSummaryModel(
                                                  position: int.parse(positionController.text),
                                                  penalty: int.parse(penaltyController.text),
                                                  bonus: int.parse(bonusController.text),
                                                  lap: int.parse(fastestController.text),
                                                  dnf: dnf,
                                                  dqf: dqf,
                                                  notes: notesController.text,
                                                  classId: widget
                                                      .viewModel
                                                      .raceStandings?[
                                                          classIndex]
                                                      ?.raceClass
                                                      ?.id,
                                                  eventId: Session.instance
                                                      .getEventId(),
                                                  raceId: Session.instance
                                                      .getRaceId()));
                                        });
                                      },
                                      label: "Save",
                                    ),
                                    const SpacingWidget(LayoutSize.size8),
                                  ],
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              );
            })).whenComplete(() {
      setup();
    });
  }

  setup() {
    dnf = false;
    dqf = false;
    positionController = TextEditingController();
    bonusController = TextEditingController();
    penaltyController = TextEditingController();
    fastestController = TextEditingController();
    notesController = TextEditingController();
  }
}
