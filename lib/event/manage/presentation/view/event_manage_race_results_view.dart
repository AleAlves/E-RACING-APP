import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ext/dialog_extension.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/manage/presentation/event_manage_view_model.dart';
import 'package:e_racing_app/event/manage/presentation/router/event_manage_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/tools/session.dart';
import '../../../../core/ui/component/ui/float_action_button_widget.dart';
import '../../../core/data/race_standings_model.dart';
import '../../../core/data/set_summary_model.dart';

class EventManageRaceResultsView extends StatefulWidget {
  final EventManageViewModel viewModel;

  const EventManageRaceResultsView(this.viewModel, {Key? key})
      : super(key: key);

  @override
  _EventManageRaceResultsViewState createState() =>
      _EventManageRaceResultsViewState();
}

class _EventManageRaceResultsViewState extends State<EventManageRaceResultsView>
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
    widget.viewModel.getStandings();
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
        bottom: finishButton(),
        floatAction: widget.viewModel.raceStandings?.isEditable == true
            ? cancelButton()
            : null,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(EventManageRouter.main);
    return false;
  }

  @override
  Widget content() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size8),
        standings(),
        const SpacingWidget(LayoutSize.size8),
      ],
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
        _addPosition(sessionIndex);
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
    String positionString = "";
    var position = standing?.summary?.position;
    if (position != null) {
      if (position < 0) {
        positionString = "-";
      } else {
        positionString = (position + 1).toString();
      }
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
                      text: positionString,
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
        ready: widget.viewModel.isUpdatingResults == false);
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
                        padding: const EdgeInsets.all(48.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                  text: "Position",
                                  style: Style.subtitle,
                                  align: TextAlign.start,
                                ),
                                const SpacingWidget(LayoutSize.size24),
                                dropDownPosition(myState)
                              ],
                            ),
                            const SpacingWidget(LayoutSize.size16),
                            Column(
                              children: [
                                InputTextWidget(
                                    enabled: widget.viewModel.raceStandings
                                            ?.isEditable ==
                                        true,
                                    inputType: InputType.number,
                                    label: "Bonus points",
                                    controller: bonusController,
                                    validator: (value) {}),
                                const SpacingWidget(LayoutSize.size16),
                                InputTextWidget(
                                    enabled: widget.viewModel.raceStandings
                                            ?.isEditable ==
                                        true,
                                    inputType: InputType.number,
                                    label: "Penalty points",
                                    controller: penaltyController,
                                    validator: (value) {}),
                                const SpacingWidget(LayoutSize.size16),
                                InputTextWidget(
                                    enabled: widget.viewModel.raceStandings
                                            ?.isEditable ==
                                        true,
                                    inputType: InputType.number,
                                    label: "Fastest Lap time",
                                    controller: fastestController,
                                    validator: (value) {}),
                                const SpacingWidget(LayoutSize.size16),
                                InputTextWidget(
                                    enabled: widget.viewModel.raceStandings
                                            ?.isEditable ==
                                        true,
                                    inputType: InputType.multilines,
                                    label: "Notes",
                                    controller: notesController,
                                    validator: (value) {}),
                              ],
                            ),
                            const SpacingWidget(LayoutSize.size16),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: dnf,
                                      onChanged: (bool? value) {
                                        if (widget.viewModel.raceStandings
                                                ?.isEditable ==
                                            true) {
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
                                        if (widget.viewModel.raceStandings
                                                ?.isEditable ==
                                            true) {
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
                            widget.viewModel.raceStandings?.isEditable == true
                                ? Column(
                                    children: [
                                      const SpacingWidget(LayoutSize.size48),
                                      ButtonWidget(
                                        enabled: widget.viewModel.raceStandings
                                                ?.isEditable ==
                                            true,
                                        type: ButtonType.primary,
                                        icon: Icons.check_circle,
                                        onPressed: () {
                                          setState(() {
                                            widget.viewModel.setSummaryResult(
                                                SetSummaryModel(
                                                    summaryId:
                                                        standing?.summary?.id,
                                                    sessionId: standing
                                                        ?.summary?.sessionId,
                                                    position: int.parse(
                                                        positionController
                                                            .text),
                                                    penalty: int.parse(
                                                        penaltyController.text),
                                                    bonus: int.parse(
                                                        bonusController.text),
                                                    lap: int.parse(
                                                        fastestController.text),
                                                    dnf: dnf,
                                                    dqf: dqf,
                                                    notes: notesController.text,
                                                    driverId:
                                                        standing?.user?.id,
                                                    classId: standing
                                                        ?.summary?.classId,
                                                    eventId: Session.instance
                                                        .getEventId(),
                                                    raceId: Session.instance.getRaceId()));
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        label: "Save",
                                      ),
                                    ],
                                  )
                                : Container(),
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

  Widget dropDownPosition(StateSetter myState) {
    return DropdownButton<String>(
      value: positionController.text,
      elevation: 16,
      onChanged: widget.viewModel.raceStandings?.isEditable == true
          ? (String? newValue) {
              myState(() {
                positionController.text = newValue!;
              });
            }
          : null,
      items: positions.map<DropdownMenuItem<String>>((String value) {
        var position = value.isEmpty ? "-" : (int.parse(value) + 1).toString();
        return DropdownMenuItem<String>(
          value: value,
          child: TextWidget(
            text: position,
            style: Style.subtitle,
          ),
        );
      }).toList(),
    );
  }

  FloatActionButtonWidget cancelButton() {
    return FloatActionButtonWidget(
        icon: Icons.cancel_outlined,
        title: "Cancel race",
        onPressed: () {
          confirmationDialogExt(
              onPositive: () {
                widget.viewModel.cancelRace();
              },
              context: context,
              issueMessage:
                  "All results will be invalidated for this race. Are you sure you want to proceed?",
              consentMessage: "Yes, I do");
        });
  }

  Widget finishButton() {
    return ButtonWidget(
      label: "Finish ${widget.viewModel.raceStandings?.isEditable}",
      type: ButtonType.primary,
      onPressed: () {
        confirmationDialogExt(
            onPositive: () {
              widget.viewModel.finishRace();
            },
            context: context,
            issueMessage:
                "By finishing this race you won't be able to edit the results anymore.\n Are you sure you want to proceed?",
            consentMessage: "Yes, I do");
      },
      enabled: widget.viewModel.raceStandings?.isEditable == true,
    );
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
    positionController.text = standing?.summary?.position == -1
        ? "0"
        : standing?.summary?.position.toString() ?? "";
    bonusController.text = standing?.summary?.bonus.toString() ?? "";
    penaltyController.text = standing?.summary?.penalty.toString() ?? "";
    fastestController.text = standing?.summary?.fastestLapTime.toString() ?? "";
    notesController.text = standing?.summary?.notes ?? "";
  }

  _addPosition(int position) {
    if (!positions.contains(position.toString())) {
      positions.add((position).toString());
    }
  }
}
