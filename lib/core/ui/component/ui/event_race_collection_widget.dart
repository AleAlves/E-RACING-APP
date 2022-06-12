import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';


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
    return Column(children: racesSteps(context),);
  }

  List<Widget> racesSteps(BuildContext context) {
    var index = 0;
    return races?.map((race){
      ++index;
      return raceCard(context, race, index);
    }).toList() ?? [];
  }

  Widget raceCard(BuildContext context, RaceModel? race, int index) {
    return Column(
      children: [
        CardWidget(
          marked: true,
          markWidth: 45,
          markColor: Theme.of(context).colorScheme.primary,
          ready: true,
          onPressed: () {
            onRaceCardPressed.call(race?.id ?? '');
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWidget(
                        color: Theme.of(context).colorScheme.onPrimary,
                          text: index.toString(),
                          style: Style.title),
                    ),
                  ),
                  const SpacingWidget(LayoutSize.size16),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.sports_score),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SpacingWidget(LayoutSize.size16),
                        Icon(
                          Icons.chevron_right,
                        ),
                      ],
                    )
                  ]),
            ],
          ),
        ),
      ],
    );
  }
}
