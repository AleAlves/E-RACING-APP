import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/ext/event_iconography_extension.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/poster_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/data/race_standings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/ui/component/ui/icon_widget.dart';
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
    widget.viewModel.setFlow(EventFlow.eventDetail);
    return false;
  }

  @override
  Widget content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        banner(),
        sessionsWidget(),
        standings(),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
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
            const SpacingWidget(LayoutSize.size16),
          ],
        ),
      ),
    );
  }

  Widget schedule() {
    return CardWidget(
      ready: true,
      shapeLess: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
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
            const SpacingWidget(LayoutSize.size24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const IconWidget(icon: Icons.schedule),
                    const SpacingWidget(LayoutSize.size8),
                    TextWidget(
                        text: formatHour(widget.viewModel.race?.date),
                        style: Style.paragraph),
                  ],
                ),
                Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const IconWidget(icon: Icons.date_range),
                    const SpacingWidget(LayoutSize.size8),
                    TextWidget(
                        text: formatDate(widget.viewModel.race?.date),
                        style: Style.paragraph),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sessionsWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.viewModel.race?.sessions?.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CardWidget(
                marked: true,
                markWidth: 40,
                markColor: Theme.of(context).focusColor,
                padding: const EdgeInsets.only(left: 16, right: 16),
                ready: true,
                onPressed: () {},
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned(
                      child: IconWidget(icon: Icons.tune),
                      top: 0,
                      bottom: 0,
                      right: 0,
                    ),
                    Row(
                      children: [
                        getSesionIcon(
                            widget.viewModel.race?.sessions?[index]?.type),
                        const SpacingWidget(LayoutSize.size24),
                        Expanded(
                          child: Column(
                            children: [
                              const SpacingWidget(LayoutSize.size8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: widget.viewModel.race
                                              ?.sessions?[index]?.name,
                                          style: Style.paragraph,
                                          align: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SpacingWidget(LayoutSize.size16),
                              sessionSettings(index),
                              const SpacingWidget(LayoutSize.size16),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                    style: Style.paragraph,
                    text:
                        "${widget.viewModel.race?.sessions?[sessionIndex]?.settings?[index]?.name}:"),
                const SpacingWidget(LayoutSize.size8),
                TextWidget(
                    style: Style.paragraph,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: widget.viewModel.raceStandings
                                  ?.classes?[index]?.className,
                              style: Style.subtitle,
                              align: TextAlign.start,
                            ),
                          ],
                        ),
                        const SpacingWidget(LayoutSize.size8),
                        classes(widget.viewModel.raceStandings?.classes?[index]?.sessions)
                      ],
                    ),
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

  Widget session(RaceStandingsSessionModel? sessions) {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size16),
        Row(
          children: [
            const IconWidget(icon: Icons.sports_score),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(
              text: sessions?.sessionName,
              style: Style.paragraph,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size16),
        driversContainer(sessions?.standings),
      ],
    );
  }

  Widget driversContainer(List<RaceStandingsSummaryModel>? standings) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      itemCount: standings?.length,
      itemBuilder: (context, sessionsIndex) {
        return driverCard(standings?[sessionsIndex]);
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
      ready: true,
      shapeLess: true,
      padding: EdgeInsets.zero,
      onPressed: () {
        showDriverSummary(standing);
      },
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  SizedBox(
                    child: Container(
                      height: 35,
                      color: getPodiumColor(standing?.summary?.position).first,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 8),
                        child: TextWidget(
                          text: "${standing?.summary?.position}º",
                          style: Style.paragraph,
                          color: getPodiumColor(standing?.summary?.position)
                              .second,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SpacingWidget(LayoutSize.size16),
              Expanded(
                child: Wrap(
                  children: [
                    TextWidget(
                      text:
                          "${standing?.user?.profile?.name?[0]}. ${standing?.user?.profile?.surname}",
                      style: Style.paragraph,
                      align: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                      text: "${standing?.summary?.points} pts",
                      style: Style.paragraph,
                      align: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const IconWidget(icon: Icons.chevron_right, borderless: false,),
              const SpacingWidget(LayoutSize.size4),
            ],
          ),
          Container(
            height: 1,
            color: Colors.black26,
          )
        ],
      ),
    );
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
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const IconWidget(icon: Icons.sports_motorsports),
                                const SpacingWidget(LayoutSize.size8),
                                TextWidget(
                                  text:
                                      "${standing?.user?.profile?.name} ${standing?.user?.profile?.surname}",
                                  style: Style.paragraph,
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
                                    style: Style.paragraph,
                                    align: TextAlign.start,
                                  ),
                                ],
                              ),
                            const SpacingWidget(LayoutSize.size16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                    style: Style.paragraph, text: "Position"),
                                const SpacingWidget(LayoutSize.size8),
                                TextWidget(
                                    style: Style.paragraph,
                                    text: "${standing?.summary?.position} th"),
                              ],
                            ),
                            const SpacingWidget(LayoutSize.size8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                    style: Style.paragraph, text: "Points"),
                                const SpacingWidget(LayoutSize.size8),
                                TextWidget(
                                    style: Style.paragraph,
                                    text: "${standing?.summary?.points} pts"),
                              ],
                            ),
                            const SpacingWidget(LayoutSize.size8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                    style: Style.paragraph, text: "Bonus"),
                                const SpacingWidget(LayoutSize.size8),
                                TextWidget(
                                    style: Style.paragraph,
                                    text: "${standing?.summary?.bonus} pts"),
                              ],
                            ),
                            const SpacingWidget(LayoutSize.size8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                    style: Style.paragraph, text: "Penalty"),
                                const SpacingWidget(LayoutSize.size8),
                                TextWidget(
                                    style: Style.paragraph,
                                    text: "${standing?.summary?.penalty} pts"),
                              ],
                            ),
                            const SpacingWidget(LayoutSize.size8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                    style: Style.paragraph,
                                    text: "Fastest lap time"),
                                const SpacingWidget(LayoutSize.size8),
                                TextWidget(
                                    style: Style.paragraph,
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
                                      style: Style.paragraph, text: "Laps"),
                                  const SpacingWidget(LayoutSize.size8),
                                  TextWidget(
                                      style: Style.paragraph,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      TextWidget(
                                          style: Style.paragraph,
                                          text: "Notes:"),
                                    ],
                                  ),
                                  const SpacingWidget(LayoutSize.size8),
                                  TextWidget(
                                      style: Style.paragraph,
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
                                  style: Style.caption,
                                  text: "Disqualified"),
                            if (standing?.summary?.didntFinish == null ||
                                standing?.summary?.didntFinish == false)
                              Container()
                            else
                              TextWidget(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  style: Style.caption,
                                  text: "DNF"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
