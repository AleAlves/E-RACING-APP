import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/event/data/event_standings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventStandingWidget extends StatefulWidget {
  final EventStandingsModel? standings;
  final Function(String) onRaceCardPressed;

  const EventStandingWidget(
      {Key? key, required this.standings, required this.onRaceCardPressed})
      : super(key: key);

  @override
  _EventStandingWidgetState createState() => _EventStandingWidgetState();
}

class _EventStandingWidgetState extends State<EventStandingWidget> {
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
              SpacingWidget(LayoutSize.size16),
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
          const SpacingWidget(LayoutSize.size48),
          ButtonWidget(
              enabled: true,
              type: ButtonType.icon,
              icon: Icons.read_more,
              label: "Full standings",
              onPressed: () {})
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
            const SpacingWidget(LayoutSize.size8),
            Expanded(
              child: Column(
                children: [
                  const SpacingWidget(LayoutSize.size16),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: getClassColor(_index),
                      ),
                      const SpacingWidget(LayoutSize.size8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: clazz?.className,
                              style: Style.subtitle,
                              align: TextAlign.start,
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
    return summaries?.map((driver) => driverCard(driver, color)).toList() ?? [Container()];
  }

  Widget driverCard(EventStandingSummaryModel? standing, Color color) {
    var position = 0;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: 1),
          Row(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 5,
                    color: color,
                  ),
                  const SpacingWidget(LayoutSize.size16),
                  TextWidget(
                    text: "${++position}º",
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
                      text: "${standing?.user?.profile?.name?[0]}. ${standing?.user?.profile?.surname}",
                      style: Style.subtitle,
                      align: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  TextWidget(
                    text: "${standing?.points} pts",
                    style: Style.subtitle,
                    align: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size4),
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: 1)
        ],
      ),
    );
  }
}
