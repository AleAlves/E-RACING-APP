import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/event/data/event_standings_model.dart';
import 'package:flutter/material.dart';

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
    return CardWidget(
      padding: EdgeInsets.zero,
      ready: widget.standings != null,
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SpacingWidget(LayoutSize.size16),
              TextWidget(
                text: "Standings",
                style: Style.title,
                align: TextAlign.start,
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: classesList(context),
            ),
          ),
          const SpacingWidget(LayoutSize.size48),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: ButtonWidget(
                  enabled: true,
                  type: ButtonType.primary,
                  icon: Icons.format_list_numbered,
                  label: "Full standings",
                  onPressed: () {
                    widget.onFullStandingsPressed();
                  }),
            ),
          ),
          const SpacingWidget(LayoutSize.size16),
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
    );
  }

  List<Widget> summaryWidget(List<EventStandingSummaryModel?>? summaries, Color color) {
    var position = 0;
    return summaries?.map((driver) {
          return Column(
            children: [
              driverCard(driver, color, ++position),
              const SpacingWidget(LayoutSize.size2),
            ],
          );
        }).toList() ??
        [Container()];
  }

  Widget driverCard(
      EventStandingSummaryModel? standing, Color color, int position) {
    return Column(
      children: [
        Row(
          children: [
            const SpacingWidget(LayoutSize.size8),
            Row(
              children: [
                Container(
                  height: 35,
                  color: getPodiumColor(position).first,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: TextWidget(
                      text: "$positionº",
                      style: Style.subtitle,
                      color: getPodiumColor(position).second,
                    ),
                  ),
                ),
                const SpacingWidget(LayoutSize.size2),
                Container(
                  height: 35,
                  width: 5,
                  color: getClassColor(_index),
                )
              ],
            ),
            const SpacingWidget(LayoutSize.size16),
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
            ),
            CountryCodePicker(
              onChanged: print,
              showCountryOnly: true,
              enabled: false,
              initialSelection: standing?.user?.profile?.country,
              hideMainText: true,
              showFlagMain: true,
              showFlag: false,
            ),
          ],
        ),
        Container(height: 1, color: Colors.black26,)
      ],
    );
  }
}
