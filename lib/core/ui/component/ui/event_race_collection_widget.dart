import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/tools/date_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'expanded_widget.dart';

class EventRaceCollection extends StatelessWidget {
  final List<RaceModel?>? races;
  final Function(String) onRaceCardPressed;
  final CarouselController buttonCarouselController = CarouselController();

  EventRaceCollection(
      {Key? key, required this.races, required this.onRaceCardPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => raceList(context);

  Widget raceList(BuildContext context) {
    return ExpandedWidget(
      body: racesSteps(context),
      header: Row(
        children: const [
          TextWidget(
            text: "Races",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
        ],
      ),
      ready: true,
    );
  }

  List<Widget> racesSteps(BuildContext context) {
    return races?.map((race) => raceCard(context, race)).toList() ?? [];
  }

  Widget raceCard(BuildContext context, RaceModel? race) {
    return CardWidget(
      ready: true,
      onPressed: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              const SpacingWidget(LayoutSize.size8),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextWidget(
                        text: race?.title,
                        style: Style.subtitle,
                        align: TextAlign.center,
                      ),
                    ),
                    const SpacingWidget(LayoutSize.size16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.date_range),
                        const SpacingWidget(LayoutSize.size8),
                        TextWidget(
                            text: formatDate(race?.date),
                            style: Style.description),
                      ],
                    ),
                    const SpacingWidget(LayoutSize.size16),
                    Row(
                      children: [
                        const Icon(Icons.schedule),
                        const SpacingWidget(LayoutSize.size8),
                        TextWidget(
                            text: formatHour(race?.date),
                            style: Style.description),
                      ],
                    ),
                    const SpacingWidget(LayoutSize.size8),
                  ],
                ),
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Ink(
                  decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    size: 24.0,
                    color: Theme.of(context).colorScheme.primaryVariant,
                  ),
                )
              ]),
        ],
      ),
    );
  }
}
