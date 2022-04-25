import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/ext/status_extensions.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/poster_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/data/race_standings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventDetailRaceWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventDetailRaceWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventDetailRaceWidgetState createState() => _EventDetailRaceWidgetState();
}

class _EventDetailRaceWidgetState extends State<EventDetailRaceWidget>
    implements BaseSateWidget {
  List<Pair<String, Color>> teamColors = [];

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
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlows.eventDetail);
    return false;
  }

  @override
  Widget content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        banner(),
        standings(),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: CardWidget(
        padding: EdgeInsets.zero,
        ready: widget.viewModel.race?.title != null,
        child: Column(
          children: [
            PosterWidget(
              post: widget.viewModel.race?.poster,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: TextWidget(
                  text: widget.viewModel.race?.title, style: Style.title),
            ),
            schedule(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandedWidget(
                  shapeless: true,
                  expandIcon: Icons.visibility_outlined,
                  collapseIcon: Icons.visibility_off_outlined,
                  header: Row(
                    children: const [
                      TextWidget(
                        text: "Sessions",
                        style: Style.subtitle,
                        align: TextAlign.left,
                      ),
                    ],
                  ),
                  body: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.viewModel.race?.sessions?.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  style: Style.subtitle,
                                  text: getSessionType(widget
                                      .viewModel.race?.sessions?[index]?.type)),
                              const SpacingWidget(LayoutSize.size8),
                              TextWidget(
                                  style: Style.subtitle,
                                  text: widget
                                      .viewModel.race?.sessions?[index]?.name),
                              const SpacingWidget(LayoutSize.size24),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 24, right: 8),
                                child: sessionSettings(index),
                              ),
                              const SpacingWidget(LayoutSize.size24),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                  ready: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget schedule() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: CardWidget(
        ready: true,
        shapeLess: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  TextWidget(
                    text: "Schedule",
                    style: Style.subtitle,
                    align: TextAlign.start,
                  ),
                ],
              ),
              const SpacingWidget(LayoutSize.size16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SpacingWidget(LayoutSize.size8),
                      TextWidget(
                          text: formatHour(widget.viewModel.race?.date),
                          style: Style.description),
                    ],
                  ),
                  Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.date_range),
                      const SpacingWidget(LayoutSize.size8),
                      TextWidget(
                          text: formatDate(widget.viewModel.race?.date),
                          style: Style.description),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sessionSettings(int sessionIndex) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount:
          widget.viewModel.race?.sessions?[sessionIndex]?.settings?.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    style: Style.subtitle,
                    text:
                        "${widget.viewModel.race?.sessions?[sessionIndex]?.settings?[index]?.name}:"),
                const SpacingWidget(LayoutSize.size8),
                TextWidget(
                    style: Style.description,
                    text: widget.viewModel.race?.sessions?[sessionIndex]
                        ?.settings?[index]?.name),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget standings() {
    if (widget.viewModel.raceStandings == null) {
      return const Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: LoadingShimmer(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.viewModel.raceStandings?.classes?.length,
              itemBuilder: (context, index) {
                return CardWidget(
                  ready: true,
                  child: Column(
                    children: [
                      const SpacingWidget(LayoutSize.size8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: widget.viewModel.raceStandings
                                ?.classes?[index]?.className,
                            style: Style.title,
                            align: TextAlign.start,
                          ),
                        ],
                      ),
                      const SpacingWidget(LayoutSize.size8),
                      classes(widget
                          .viewModel.raceStandings?.classes?[index]?.sessions)
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

  Widget session(RaceStandingsSessionModel? sessions){
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size16),
        Row(
          children: [
            const Icon(Icons.sports_score),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(
              text: sessions?.sessionName,
              style: Style.subtitle,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size16),
        driversContainer(sessions?.standings),
      ],
    );
  }

  Widget driversContainer(List<RaceStandingsSummaryModel>? standings){
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: standings?.length,
      itemBuilder: (context, sessionsIndex) {
        return Column(
          children: [
            driverCard(standings?[sessionsIndex]),
          ],
        );
      },
    );
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
                  Icons.navigate_next,
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

  void showDriverSummary(RaceStandingsSummaryModel? standing) {
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
}
