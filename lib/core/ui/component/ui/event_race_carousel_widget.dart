import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/tools/date_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/poster_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventRaceCarousel extends StatelessWidget {
  final List<RaceModel?>? races;
  final CarouselController buttonCarouselController = CarouselController();

  EventRaceCarousel({Key? key, required this.races}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        CardWidget(
          padding: const EdgeInsets.all(0),
          onPressed: () {},
          ready: races != null,
          child: CarouselSlider(
            items: races?.map((race) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(text: race?.title, style: Style.subtitle),
                            const SpacingWidget(LayoutSize.size48),
                            PosterWidget(post: race?.poster),
                            const SpacingWidget(LayoutSize.size48),
                            TextWidget(text: formatDate(race?.date), style: Style.description),
                            const SpacingWidget(LayoutSize.size8),
                            TextWidget(text: formatHour(race?.date), style: Style.description),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
            carouselController: buttonCarouselController,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                height:  MediaQuery.of(context).size.height / 1.7,
                viewportFraction: 0.8,
                initialPage: 0),
          ),
        ),
      ]);
}
