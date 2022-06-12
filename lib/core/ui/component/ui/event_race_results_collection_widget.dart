import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';


class EventRaceResultsCollection extends StatelessWidget {
  final List<RaceModel?>? races;
  final Function(String) onRaceCardPressed;
  final CarouselController buttonCarouselController = CarouselController();

  EventRaceResultsCollection(
      {Key? key, required this.races, required this.onRaceCardPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => raceList(context);

  Widget raceList(BuildContext context) {
    return CardWidget(
        ready: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.manage_accounts),
                  SpacingWidget(LayoutSize.size8),
                  TextWidget(
                    text: "Race director",
                    style: Style.title,
                    align: TextAlign.left,
                  ),
                ],
              ),
              const SpacingWidget(LayoutSize.size16),
              Column(
                children: racesSteps(context),
              ),
            ],
          ),
        ));
  }

  List<Widget> racesSteps(BuildContext context) {
    return races?.map((race) => raceCard(context, race)).toList() ?? [];
  }

  Widget raceCard(BuildContext context, RaceModel? race) {
    return Column(
      children: [
        CardWidget(
          marked: true,
          ready: true,
          shapeLess: true,
          onPressed: () {
            onRaceCardPressed.call(race?.id ?? '');
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  const SpacingWidget(LayoutSize.size8),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.sports_score_outlined),
                            const SpacingWidget(LayoutSize.size8),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: race?.title,
                                    style: Style.subtitle,
                                    align: TextAlign.start,
                                  ),
                                ],
                              ),
                            )
                          ],
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
                      ],
                    ),
                  )
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.build,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  ]),
            ],
          ),
        ),
        const SpacingWidget(LayoutSize.size8),
      ],
    );
  }
}
