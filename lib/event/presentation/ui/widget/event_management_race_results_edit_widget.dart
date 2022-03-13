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
  final _formKey = GlobalKey<FormState>();

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
        standings(),
        const SpacingWidget(LayoutSize.size16),
        canceledWidget(),
        const SpacingWidget(LayoutSize.size8),
        finishWidget()
      ],
    );
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
                    children: [
                      TextWidget(
                          style: Style.subtitle,
                          text: widget.viewModel.raceStandings?[index]
                              ?.raceClass?.name),
                      const SpacingWidget(LayoutSize.size16),
                      drivers(widget.viewModel.raceStandings?[index]?.standings)
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

  Widget driverCard(RaceStandingsSummaryModel? standing) {
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

  Widget drivers(List<RaceStandingsSummaryModel>? standings) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: standings?.length,
      itemBuilder: (context, index) {
        return driverCard(standings?[index]);
      },
    );
  }

  showDriverSummary(RaceStandingsSummaryModel? standing) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return SizedBox(
                child: Wrap(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CardWidget(
                          ready: true,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextWidget(
                                      style: Style.subtitle, text: "Position"),
                                  const SpacingWidget(LayoutSize.size8),
                                  TextWidget(
                                      style: Style.description,
                                      text:
                                          "${standing?.summary?.position} th"),
                                ],
                              ),
                              const SpacingWidget(LayoutSize.size8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextWidget(
                                      style: Style.subtitle, text: "Points"),
                                  const SpacingWidget(LayoutSize.size8),
                                  TextWidget(
                                      style: Style.description,
                                      text: "${standing?.summary?.points} pts"),
                                ],
                              ),
                              const SpacingWidget(LayoutSize.size8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextWidget(
                                      style: Style.subtitle, text: "Bonus"),
                                  const SpacingWidget(LayoutSize.size8),
                                  TextWidget(
                                      style: Style.description,
                                      text: "${standing?.summary?.bonus} pts"),
                                ],
                              ),
                              const SpacingWidget(LayoutSize.size8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextWidget(
                                      style: Style.subtitle, text: "Penalty"),
                                  const SpacingWidget(LayoutSize.size8),
                                  TextWidget(
                                      style: Style.description,
                                      text:
                                          "${standing?.summary?.penalty} pts"),
                                ],
                              ),
                              const SpacingWidget(LayoutSize.size8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextWidget(
                                      style: Style.subtitle,
                                      text: "Fastest lap time"),
                                  const SpacingWidget(LayoutSize.size8),
                                  TextWidget(
                                      style: Style.description,
                                      text:
                                          "${standing?.summary?.fastestLapTime}"),
                                ],
                              ),
                              const SpacingWidget(LayoutSize.size8),
                              if (standing?.summary?.laps == null)
                                Container()
                              else
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextWidget(
                                        style: Style.subtitle, text: "Laps"),
                                    const SpacingWidget(LayoutSize.size8),
                                    TextWidget(
                                        style: Style.description,
                                        text: "${standing?.summary?.laps}"),
                                  ],
                                ),
                              const SpacingWidget(LayoutSize.size8),
                              if (standing?.summary?.notes == null)
                                Container()
                              else
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const TextWidget(
                                        style: Style.subtitle, text: "Notes:"),
                                    const SpacingWidget(LayoutSize.size8),
                                    TextWidget(
                                        style: Style.description,
                                        text: "${standing?.summary?.notes}"),
                                  ],
                                ),
                              if (standing?.summary?.disqualified == null ||
                                  standing?.summary?.disqualified == false)
                                Container()
                              else
                                TextWidget(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    style: Style.shadow,
                                    text: "Disqualified"),
                              if (standing?.summary?.didntFinish == null ||
                                  standing?.summary?.didntFinish == false)
                                Container()
                              else
                                TextWidget(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    style: Style.shadow,
                                    text: "DNF"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  Widget canceledWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.normal,
      onPressed: () {
        //widget.viewModel.updateRace(model);
      },
      label: "Canceled",
    );
  }

  Widget finishWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.normal,
      onPressed: () {
        //widget.viewModel.updateRace(model);
      },
      label: "Finish",
    );
  }
}
