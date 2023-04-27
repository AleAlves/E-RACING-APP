import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../event/core/data/event_standings_model.dart';
import 'icon_widget.dart';

class FullStandingsWidget extends StatefulWidget {
  final EventStandingsModel? standings;

  const FullStandingsWidget({Key? key, required this.standings})
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
    return Stack(
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
                      const SpacingWidget(LayoutSize.size8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: clazz?.className,
                                style: Style.caption,
                                align: TextAlign.start),
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
    );
  }

  List<Widget> summaryWidget(
      List<EventStandingSummaryModel?>? summaries, Color color) {
    var position = 0;
    return summaries?.map((driver) {
          return driverContainer(driver, color, ++position);
        }).toList() ??
        [Container()];
  }

  Widget driverContainer(
      EventStandingSummaryModel? standing, Color color, int position) {
    return Column(
      children: [
        driverCard(standing, color, position),
      ],
    );
  }

  Widget driverCard(
      EventStandingSummaryModel? standing, Color color, int position) {
    return CardWidget(
      ready: true,
      shapeLess: true,
      padding: EdgeInsets.zero,
      onPressed: () {
        showResume(standing);
      },
      child: Container(
        color: Colors.black12,
        child: Column(
          children: [
            Row(
              children: [
                const SpacingWidget(LayoutSize.size8),
                Row(
                  children: [
                    Container(
                      color: getPodiumColor(position).first,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                          text: "$positionº",
                          style: Style.paragraph,
                          color: getPodiumColor(position).second,
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CountryCodePicker(
                      onChanged: print,
                      showCountryOnly: true,
                      enabled: false,
                      initialSelection: standing?.user?.profile?.country,
                      hideMainText: true,
                      showFlagMain: true,
                      showFlag: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWidget(
                        text: "${standing?.points} pts",
                        style: Style.paragraph,
                        align: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const IconWidget(
                  icon: Icons.chevron_right,
                  borderless: false,
                ),
                const SpacingWidget(LayoutSize.size4),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showResume(EventStandingSummaryModel? standing) {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return driverResume(standing);
            }));
  }

  Widget driverResume(EventStandingSummaryModel? standing) {
    return Wrap(
      children: [
        Padding(
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
              const SpacingWidget(LayoutSize.size16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                      style: Style.paragraph, text: "Bonus points"),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                      style: Style.paragraph, text: "${standing?.bonus} pts"),
                ],
              ),
              const SpacingWidget(LayoutSize.size8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(style: Style.paragraph, text: "Penalties"),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                      style: Style.paragraph,
                      text: "${standing?.penalties} pts"),
                ],
              ),
              const SpacingWidget(LayoutSize.size8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(style: Style.paragraph, text: "Wins"),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                      style: Style.paragraph, text: "${standing?.wins} pts"),
                ],
              ),
              const SpacingWidget(LayoutSize.size8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(style: Style.paragraph, text: "Top 5"),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(style: Style.paragraph, text: "${standing?.top5}"),
                ],
              ),
              const SpacingWidget(LayoutSize.size8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(style: Style.paragraph, text: "Top 10"),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                      style: Style.paragraph, text: "${standing?.top10}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                      style: Style.paragraph, text: "Best position"),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                      style: Style.paragraph,
                      text: "${standing?.bestPosition}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                      style: Style.paragraph, text: "Worst position"),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                      style: Style.paragraph,
                      text: "${standing?.worstPosition}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                      style: Style.paragraph, text: "Disqualification"),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                      style: Style.paragraph,
                      text: "${standing?.desqualifies}"),
                ],
              ),
              const SpacingWidget(LayoutSize.size8),
            ],
          ),
        ),
      ],
    );
  }
}
