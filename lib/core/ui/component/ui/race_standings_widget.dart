import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/event/data/event_standing_model.dart';
import 'package:e_racing_app/event/data/race_standings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RaceStandingsWidget extends StatefulWidget {
  final List<RaceStandingsModel>? raceStandings;

  const RaceStandingsWidget({Key? key, required this.raceStandings})
      : super(key: key);

  @override
  _RaceStandingsWidgetState createState() => _RaceStandingsWidgetState();
}

class _RaceStandingsWidgetState extends State<RaceStandingsWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => raceList(context);

  Widget raceList(BuildContext context) {
    return CardWidget(
      ready: widget.raceStandings != null,
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size16),
          const TextWidget(
            text: "Standings",
            style: Style.subtitle,
            align: TextAlign.start,
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


  List<Widget> driverList(List<EventStandingModel?>? entries, Color color) {
    return entries?.map((driver) => driverCard(driver, color)).toList() ??
        [Container()];
  }

  Widget driverCard(EventStandingModel? standing, Color color) {
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
                    text: "${standing?.points}º",
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
