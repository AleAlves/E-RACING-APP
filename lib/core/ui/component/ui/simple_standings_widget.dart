import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../event/core/data/event_standings_model.dart';

class SimpleStandingsWidget extends StatefulWidget {
  final EventStandingsModel? standings;
  final Function(String) onRaceCardPressed;
  final Function onFullStandingsPressed;

  const SimpleStandingsWidget(
      {Key? key,
      required this.standings,
      required this.onRaceCardPressed,
      required this.onFullStandingsPressed})
      : super(key: key);

  @override
  _SimpleStandingsWidgetState createState() => _SimpleStandingsWidgetState();
}

class _SimpleStandingsWidgetState extends State<SimpleStandingsWidget> {
  var _index = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => raceList(context);

  Widget raceList(BuildContext context) {
    _index = 0;
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SpacingWidget(LayoutSize.size8),
            TextWidget(
              text: "Standings",
              style: Style.subtitle,
              align: TextAlign.start,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size16),
        Column(
          children: classesList(context),
        ),
        const SpacingWidget(LayoutSize.size16),
        ButtonWidget(
            enabled: true,
            type: ButtonType.link,
            label: "Full standings",
            onPressed: () {
              widget.onFullStandingsPressed();
            }),
        const SpacingWidget(LayoutSize.size16),
      ],
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
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
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
                          align: TextAlign.start,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SpacingWidget(LayoutSize.size8),
              clazz?.summaries?.isEmpty == true
                  ? Column(
                      children: [
                        const SpacingWidget(LayoutSize.size8),
                        Row(
                          children: const [
                            SpacingWidget(LayoutSize.size16),
                            TextWidget(
                              text: "----------------",
                              style: Style.caption,
                              align: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: summaryWidget(clazz?.summaries, color),
                    )
            ],
          ),
        )
      ],
    );
  }

  List<Widget> summaryWidget(
      List<EventStandingSummaryModel?>? summaries, Color color) {
    var position = 0;
    return summaries?.map((driver) {
          return Column(
            children: [
              driverCard(driver, color, ++position),
            ],
          );
        }).toList() ??
        [Container()];
  }

  Widget driverCard(
      EventStandingSummaryModel? standing, Color color, int position) {
    return CardWidget(
      ready: true,
      childLeftColor: getPodiumColor(position).first,
      childLeft: TextWidget(
        text: "$position",
        style: Style.paragraph,
        color: getPodiumColor(position).second,
      ),
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        text: "${standing?.points} pts",
                        style: Style.paragraph,
                        align: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                CountryCodePicker(
                  onChanged: print,
                  showCountryOnly: true,
                  padding: EdgeInsets.zero,
                  enabled: false,
                  initialSelection: standing?.user?.profile?.country,
                  hideMainText: true,
                  showFlagMain: true,
                  showFlag: false,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
