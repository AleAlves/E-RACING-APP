import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/event/data/event_standing_classes_model.dart';
import 'package:e_racing_app/event/data/event_standing_model.dart';
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
    return widget.standings?.classes?.map((clazz) {
          ++_index;
          return raceCard(context, clazz, _getClassColor());
        }).toList() ??
        [Container()];
  }

  Widget raceCard(
      BuildContext context, EventStandingClassesModel? clazz, Color color) {
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
                        color: _getClassColor(),
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
                    children: driverList(clazz?.standings, color),
                  )
                ],
              ),
            )
          ],
        ),
      ],
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

  Color _getClassColor() {
    switch (_index) {
      case 1:
        return const Color(0xFFB600B2);
      case 2:
        return const Color(0xFF00E0E0);
      case 3:
        return const Color(0xFF3BA300);
      case 4:
        return const Color(0xFFE80051);
      case 5:
        return const Color(0xFF00E0E0);
      case 6:
        return const Color(0xFF58003F);
      case 7:
        return const Color(0xFFF52C00);
      case 8:
        return const Color(0xFF1E205C);
      case 9:
        return const Color(0xFF236A00);
      case 10:
        return const Color(0xFFB0ABFF);
      default:
        return const Color(0xFF1F6DC1);
    }
  }
}
