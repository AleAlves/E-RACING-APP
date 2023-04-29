import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import 'icon_widget.dart';

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
    return Column(
      children: racesSteps(context),
    );
  }

  List<Widget> racesSteps(BuildContext context) {
    var index = 0;
    return races?.map((race) {
          ++index;
          return raceCard(context, race, index);
        }).toList() ??
        [];
  }

  Widget raceCard(BuildContext context, RaceModel? race, int index) {
    return CardWidget(
      arrowed: true,
      childLeft: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextWidget(
            color: Theme.of(context).colorScheme.onBackground,
            text: index.toString(),
            style: Style.subtitle),
      ),
      ready: true,
      onPressed: () {
        onRaceCardPressed.call(race?.id ?? '');
      },
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
                        raceStatusWidget(race),
                        const SpacingWidget(LayoutSize.size8),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: race?.title,
                                style: Style.paragraph,
                                align: TextAlign.start,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SpacingWidget(LayoutSize.size8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const IconWidget(
                          icon: Icons.date_range,
                        ),
                        const SpacingWidget(LayoutSize.size8),
                        TextWidget(
                            text: formatDate(race?.date),
                            style: Style.paragraph),
                      ],
                    ),
                    const SpacingWidget(LayoutSize.size8),
                    Row(
                      children: [
                        const IconWidget(
                          icon: Icons.schedule,
                        ),
                        const SpacingWidget(LayoutSize.size8),
                        TextWidget(
                            text: formatHour(race?.date),
                            style: Style.paragraph),
                      ],
                    ),
                    const SpacingWidget(LayoutSize.size8),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget raceStatusWidget(RaceModel? race) {
    var color = Colors.amber;
    if (race?.finished == true) {
      color = Colors.green;
    } else if (race?.canceled == true) {
      color = Colors.red;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconWidget(
          icon: Icons.flag,
          color: color,
        ),
      ],
    );
  }
}
