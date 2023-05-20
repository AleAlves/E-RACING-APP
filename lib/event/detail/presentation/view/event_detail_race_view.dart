import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/ext/event_iconography_extension.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/icon_widget.dart';
import '../../../../core/ui/component/ui/poster_widget.dart';
import '../../../core/data/race_standings_model.dart';
import '../event_detail_view_model.dart';
import '../router/event_detail_router.dart';

class EventDetailRaceView extends StatefulWidget {
  final EventDetailViewModel viewModel;

  const EventDetailRaceView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventDetailRaceViewState createState() => _EventDetailRaceViewState();
}

class _EventDetailRaceViewState extends State<EventDetailRaceView>
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
        body: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(EventDetailRouter.main);
    return false;
  }

  @override
  Widget content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        banner(),
        sessionsWidget(),
        const SpacingWidget(LayoutSize.size8),
        standings(),
        const SpacingWidget(LayoutSize.size8),
      ],
    );
  }

  Widget banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PosterWidget(
            post: widget.viewModel.racePoster?.image,
            loadDefault: widget.viewModel.shouldLoadDefaultPoster,
          ),
          const SpacingWidget(LayoutSize.size16),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: [
                TextWidget(
                  text: widget.viewModel.race?.title,
                  style: Style.title,
                  align: TextAlign.start,
                ),
              ],
            ),
          ),
          const SpacingWidget(LayoutSize.size16),
          schedule(),
          const SpacingWidget(LayoutSize.size16),
        ],
      ),
    );
  }

  Widget schedule() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            children: const [
              TextWidget(
                text: "Schedule",
                style: Style.subtitle,
                align: TextAlign.start,
              ),
            ],
          ),
        ),
        const SpacingWidget(LayoutSize.size16),
        Row(
          children: [
            const SpacingWidget(LayoutSize.size8),
            const IconWidget(icon: Icons.schedule),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(
                text: formatHourWithGMT(widget.viewModel.race?.date),
                style: Style.caption),
          ],
        ),
        const SpacingWidget(LayoutSize.size16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SpacingWidget(LayoutSize.size8),
            const IconWidget(icon: Icons.date_range),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(
                text: formatDate(widget.viewModel.race?.date),
                style: Style.caption),
          ],
        )
      ],
    );
  }

  Widget sessionsWidget() {
    return widget.viewModel.race == null
        ? const LoadingShimmer(
            height: 100,
          )
        : Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.viewModel.race?.sessions?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SpacingWidget(LayoutSize.size8),
                    getSesion(widget.viewModel.race?.sessions?[index]?.type),
                    Row(
                      children: [
                        const SpacingWidget(LayoutSize.size8),
                        sessionSettings(index),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
  }

  Widget sessionSettings(int sessionIndex) {
    return widget.viewModel.race?.sessions?[sessionIndex]?.settings?.isEmpty ==
            true
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              direction: Axis.vertical,
              children: widget.viewModel.race?.sessions?[sessionIndex]?.settings
                  ?.map((e) {
                    return Row(
                      children: [
                        TextWidget(style: Style.caption, text: "${e?.name}:"),
                        const SpacingWidget(LayoutSize.size8),
                        TextWidget(style: Style.caption, text: e?.name),
                      ],
                    );
                  })
                  .toList()
                  .cast<Widget>() as List<Widget>,
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
        children: widget.viewModel.raceStandings?.classes
            ?.map((e) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SpacingWidget(LayoutSize.size8),
                      TextWidget(
                        text: e?.className,
                        style: Style.subtitle,
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                  const SpacingWidget(LayoutSize.size16),
                  classes(e?.sessions)
                ],
              );
            })
            .toList()
            .cast<Widget>() as List<Widget>,
      );
    }
  }

  Widget classes(List<RaceStandingsSessionModel?>? sessions) {
    var raceIndex = 0;
    return Wrap(
      children: sessions
          ?.map((e) {
            raceIndex++;
            return session(e, raceIndex);
          })
          .toList()
          .cast<Widget>() as List<Widget>,
    );
  }

  Widget session(RaceStandingsSessionModel? sessions, int raceIndex) {
    return Column(
      children: [
        Row(
          children: [
            const SpacingWidget(LayoutSize.size16),
            getSesion(sessions?.type),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(
              text: "$raceIndex",
              style: Style.caption,
              align: TextAlign.start,
            )
          ],
        ),
        const SpacingWidget(LayoutSize.size16),
        driversContainer(sessions?.standings),
      ],
    );
  }

  Widget driversContainer(List<RaceStandingsSummaryModel>? standings) {
    return standings?.isEmpty == true
        ? Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: const [
                SpacingWidget(LayoutSize.size32),
                TextWidget(
                  text: "--------------------------",
                  style: Style.caption,
                  align: TextAlign.start,
                ),
              ],
            ),
          )
        : Wrap(
            children: standings
                ?.map((e) {
                  return driverCard(e);
                })
                .toList()
                .cast<Widget>() as List<Widget>,
          );
  }

  Widget driverCard(RaceStandingsSummaryModel? standing) {
    if (teamColors
            .where((element) => element.first == standing?.team?.id)
            .isEmpty ==
        true) {
      teamColors.add(Pair(standing?.team?.id, getTeamColor(teamColors.length)));
    }
    var position = standing?.summary?.position;
    if (position != null) {
      position = position + 1;
    }
    return CardWidget(
      ready: true,
      arrowed: true,
      childLeftColor: getPodiumColor(position).first,
      childLeft: TextWidget(
        text: "$position",
        style: Style.paragraph,
        color: getPodiumColor(position).second,
      ),
      padding: EdgeInsets.zero,
      onPressed: () {
        showDriverSummary(standing, position);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const SpacingWidget(LayoutSize.size16),
                Expanded(
                  child: Wrap(
                    children: [
                      TextWidget(
                        text:
                            "${standing?.user?.profile?.firstName?[0]}. ${standing?.user?.profile?.surName}",
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDriverSummary(RaceStandingsSummaryModel? standing, int? position) {
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
                                const IconWidget(
                                    icon: Icons.sports_motorsports),
                                const SpacingWidget(LayoutSize.size8),
                                TextWidget(
                                  text:
                                      "${standing?.user?.profile?.firstName} ${standing?.user?.profile?.surName}",
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
                                    text: "$position th"),
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
