import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/event/data/event_standings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullStandingsWidget extends StatefulWidget {
  final EventStandingsModel? standings;
  final Function(String) onRaceCardPressed;
  final Function onFullStandingsPressed;

  const FullStandingsWidget(
      {Key? key,
      required this.standings,
      required this.onRaceCardPressed,
      required this.onFullStandingsPressed})
      : super(key: key);

  @override
  _FullStandingsWidgetState createState() => _FullStandingsWidgetState();
}

class _FullStandingsWidgetState extends State<FullStandingsWidget> {
  var _index = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => raceList(context);

  Widget raceList(BuildContext context) {
    _index = 0;
    return CardWidget(
      ready: widget.standings != null,
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SpacingWidget(LayoutSize.size8),
              TextWidget(
                text: "General",
                style: Style.subtitle,
                align: TextAlign.start,
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size16),
          Column(
            children: classesList(context),
          ),
          const SpacingWidget(LayoutSize.size8),
        ],
      ),
    );
  }

  List<Widget> classesList(BuildContext context) {
    return widget.standings?.classes!.map((clazz) {
          ++_index;
          return raceCard(context, clazz, getClassColor(_index));
        }).toList() ??
        [Container()];
  }

  Widget raceCard(
      BuildContext context, EventStandingsClassesModel? clazz, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SpacingWidget(LayoutSize.size8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: clazz?.className,
                                style: Style.subtitle,
                                align: TextAlign.start,
                                color: getClassColor(_index),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SpacingWidget(LayoutSize.size16),
                    Column(
                      children: summaryWidget(clazz?.summaries, color),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> summaryWidget(
      List<EventStandingSummaryModel?>? summaries, Color color) {
    return summaries
            ?.map((driver) => driverContainer(driver, color))
            .toList() ??
        [Container()];
  }

  Widget driverContainer(EventStandingSummaryModel? standing, Color color) {
    return ExpandedWidget(
      header: driverCard(standing, color),
      body: [driverResume(standing)],
      ready: true,
      shapeless: true,
    );
  }

  Widget driverCard(EventStandingSummaryModel? standing, Color color) {
    var position = 0;
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 5,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: getPodiumColor(++position).first,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: TextWidget(
                      text: "$positionº",
                      style: Style.subtitle,
                      color: getPodiumColor(position).second,
                    ),
                  ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: "${standing?.points} pts",
                    style: Style.subtitle,
                    align: TextAlign.start,
                  ),
                ),
              ],
            )
          ],
        ),
        const SpacingWidget(LayoutSize.size4),
      ],
    );
  }

  Widget driverResume(EventStandingSummaryModel? standing) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: "${standing?.bonus} bonus points",
          style: Style.subtitle,
        ),
        TextWidget(
          text: "${standing?.penalties} penalty points",
          style: Style.subtitle,
        ),
        TextWidget(
          text: "${standing?.wins} wins",
          style: Style.subtitle,
        ),
        TextWidget(
          text: "${standing?.top5} top 5",
          style: Style.subtitle,
        ),
        TextWidget(
          text: "${standing?.top5} top 10",
          style: Style.subtitle,
        ),
        TextWidget(
          text: "${standing?.bestPosition} place, best position",
          style: Style.subtitle,
        ),
        TextWidget(
          text: "${standing?.worstPosition} place, worst position",
          style: Style.subtitle,
        ),
        TextWidget(
          text: "${standing?.desqualifies} Desqualifications",
          style: Style.subtitle,
        ),
      ],
    );
  }
}
