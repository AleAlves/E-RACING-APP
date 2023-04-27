import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ext/dialog_extension.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../data/race_standings_model.dart';
import '../../../data/set_summary_model.dart';
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
  List<String> positions = ['', '0'];
  List<Pair<String, Color>> teamColors = [];
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
  observers() {
    clear();
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
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
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size8),
        standings(),
        raceStatus(),
        const SpacingWidget(LayoutSize.size8),
      ],
    );
  }

  Widget raceStatus() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: const [
              TextWidget(style: Style.title, text: "Race status"),
            ],
          ),
          finishRace(),
        ],
      ),
    );
  }

  Widget standings() {
    if (widget.viewModel.raceStandings == null) {
      return const Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: LoadingShimmer(),
      );
    } else {
      return Wrap(
        spacing: 1.0,
        runSpacing: 2.0,
        children: widget.viewModel.raceStandings!.classes!
            .map((raceClasses) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SpacingWidget(LayoutSize.size8),
                    const TextWidget(style: Style.title, text: "Results"),
                    const SpacingWidget(LayoutSize.size16),
                    TextWidget(
                      text: raceClasses?.className,
                      style: Style.subtitle,
                      align: TextAlign.start,
                    ),
                    const SpacingWidget(LayoutSize.size16),
                    classes(raceClasses?.sessions)
                  ],
                ),
              );
            })
            .toList()
            .cast<Widget>(),
      );
    }
  }

  Widget classes(List<RaceStandingsSessionModel?>? sessions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: sessions?.length,
      itemBuilder: (context, index) {
        return session(sessions?[index]);
      },
    );
  }

  Widget session(RaceStandingsSessionModel? sessions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: sessions?.sessionName,
          style: Style.subtitle,
          align: TextAlign.start,
        ),
        const SpacingWidget(LayoutSize.size8),
        driversContainer(sessions?.standings),
      ],
    );
  }

  Widget driversContainer(List<RaceStandingsSummaryModel>? standings) {
    var sessionIndex = 0;
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: standings?.length,
      itemBuilder: (context, sessionsIndex) {
        ++sessionIndex;
        addPosition(sessionIndex);
        return Column(
          children: [
            driverCard(sessionIndex, standings?[sessionsIndex]),
          ],
        );
      },
    );
  }

  Widget driverCard(int sessionIndex, RaceStandingsSummaryModel? standing) {
    if (teamColors
            .where((element) => element.first == standing?.team?.id)
            .isEmpty ==
        true) {
      teamColors.add(Pair(standing?.team?.id, getTeamColor(teamColors.length)));
    }
    return CardWidget(
        onPressed: () {
          setState(() {
            showDriverSummary(standing);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.assignment_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
        placeholderHeight: 40,
        ready: widget.viewModel.isUpdatingDriverResult == false);
  }

  showDriverSummary(RaceStandingsSummaryModel? standing) {
    setup(standing);
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
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const IconWidget(
                                    icon: Icons.sports_motorsports),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.group,
                                    color: teamColors
                                        .firstWhere((element) =>
                                            element.first == standing?.team?.id)
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
                            CardWidget(
                              onPressed: () {},
                              ready: true,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const TextWidget(
                                    text: "Position",
                                    style: Style.subtitle,
                                    align: TextAlign.start,
                                  ),
                                  const SpacingWidget(LayoutSize.size24),
                                  DropdownButton<String>(
                                    value: positionController.text,
                                    elevation: 16,
                                    onChanged: (String? newValue) {
                                      myState(() {
                                        positionController.text = newValue!;
                                      });
                                    },
                                    items: positions
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text("# $value"),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SpacingWidget(LayoutSize.size16),
                            CardWidget(
                                child: Column(
                                  children: [
                                    InputTextWidget(
                                        enabled: widget.viewModel
                                                .isUpdatingDriverResult ==
                                            false,
                                        inputType: InputType.number,
                                        label: "Bonus points",
                                        controller: bonusController,
                                        validator: (value) {}),
                                    const SpacingWidget(LayoutSize.size16),
                                    InputTextWidget(
                                        enabled: widget.viewModel
                                                .isUpdatingDriverResult ==
                                            false,
                                        inputType: InputType.number,
                                        label: "Penalty points",
                                        controller: penaltyController,
                                        validator: (value) {}),
                                    const SpacingWidget(LayoutSize.size16),
                                    InputTextWidget(
                                        enabled: widget.viewModel
                                                .isUpdatingDriverResult ==
                                            false,
                                        inputType: InputType.number,
                                        label: "Fastest Lap time",
                                        controller: fastestController,
                                        validator: (value) {}),
                                    const SpacingWidget(LayoutSize.size16),
                                    InputTextWidget(
                                        enabled: widget.viewModel
                                                .isUpdatingDriverResult ==
                                            false,
                                        inputType: InputType.multilines,
                                        label: "Notes",
                                        controller: notesController,
                                        validator: (value) {}),
                                  ],
                                ),
                                ready: true),
                            const SpacingWidget(LayoutSize.size16),
                            CardWidget(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: dnf,
                                          onChanged: (bool? value) {
                                            if (widget.viewModel
                                                    .isUpdatingDriverResult ==
                                                false) {
                                              myState(() {
                                                dnf = value ?? false;
                                              });
                                            }
                                          },
                                        ),
                                        const TextWidget(
                                            text: "Didn't finish the race",
                                            style: Style.paragraph)
                                      ],
                                    ),
                                    const SpacingWidget(LayoutSize.size8),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: dqf,
                                          onChanged: (bool? value) {
                                            if (widget.viewModel
                                                    .isUpdatingDriverResult ==
                                                false) {
                                              myState(() {
                                                dqf = value ?? false;
                                              });
                                            }
                                          },
                                        ),
                                        const TextWidget(
                                            text: "Desqualified",
                                            style: Style.paragraph)
                                      ],
                                    ),
                                  ],
                                ),
                                ready: true),
                            const SpacingWidget(LayoutSize.size48),
                            ButtonWidget(
                              enabled: true,
                              type: ButtonType.iconButton,
                              icon: Icons.check_circle,
                              onPressed: () {
                                setState(() {
                                  widget.viewModel.setSummaryResult(
                                      SetSummaryModel(
                                          summaryId: standing?.summary?.id,
                                          sessionId: standing
                                              ?.summary?.sessionId,
                                          position: int.parse(
                                              positionController.text),
                                          penalty:
                                              int.parse(penaltyController.text),
                                          bonus:
                                              int.parse(bonusController.text),
                                          lap:
                                              int.parse(fastestController.text),
                                          dnf: dnf,
                                          dqf: dqf,
                                          notes: notesController.text,
                                          driverId: standing?.user?.id,
                                          classId: standing?.summary?.classId,
                                          eventId:
                                              Session.instance.getEventId(),
                                          raceId:
                                              Session.instance.getRaceId()));
                                  Navigator.of(context).pop();
                                });
                              },
                              label: "Save",
                            ),
                            const SpacingWidget(LayoutSize.size8),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  Widget finishRace() {
    return CardWidget(
        child: Column(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                SpacingWidget(LayoutSize.size8),
                TextWidget(
                  text: "Conclusion",
                  style: Style.subtitle,
                  align: TextAlign.left,
                ),
              ],
            ),
            const SpacingWidget(LayoutSize.size24),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ButtonWidget(
                label: "Cancel",
                type: ButtonType.important,
                onPressed: () {
                  confirmationDialogExt(
                      onPositive: () {},
                      context: context,
                      issueMessage:
                          "By canceling this race any result will be invalidated. Are you sure you want to proceed?",
                      consentMessage: "Yes, I do");
                },
                enabled: true,
              ),
            ),
            const SpacingWidget(LayoutSize.size24),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ButtonWidget(
                label: "Finish",
                type: ButtonType.primary,
                onPressed: () {
                  confirmationDialogExt(
                      onPositive: () {},
                      context: context,
                      issueMessage:
                          "By finishing this race you won't be able to edit the results anymore. Are you sure you want to proceed?",
                      consentMessage: "Yes, I do");
                },
                enabled: true,
              ),
            ),
            const SpacingWidget(LayoutSize.size8),
          ],
        ),
        ready: true);
  }

  clear() {
    positionController = TextEditingController();
    bonusController = TextEditingController();
    penaltyController = TextEditingController();
    fastestController = TextEditingController();
    notesController = TextEditingController();
    dnf = false;
    dqf = false;
  }

  setup(RaceStandingsSummaryModel? standing) {
    clear();
    dnf = standing?.summary?.didntFinish ?? false;
    dqf = standing?.summary?.disqualified ?? false;
    positionController.text = standing?.summary?.position.toString() ?? "";
    bonusController.text = standing?.summary?.bonus.toString() ?? "";
    penaltyController.text = standing?.summary?.penalty.toString() ?? "";
    fastestController.text = standing?.summary?.fastestLapTime.toString() ?? "";
    notesController.text = standing?.summary?.notes ?? "";
  }

  addPosition(int position) {
    if (!positions.contains(position.toString())) {
      positions.add(position.toString());
    }
  }
}
