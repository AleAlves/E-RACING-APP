import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class EventsCardWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const EventsCardWidget({this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: content(context),
      onPressed: onPressed,
      ready: true,
    );
  }

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.sports_score_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: TextWidget(
                      text: "Events",
                      style: Style.title,
                    ),
                  ),
                  SpacingWidget(LayoutSize.size8),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: TextWidget(
                      text: "Drivers needed",
                      style: Style.description,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size8),
          Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.onBackground,
            size: 24,
          ),
        ],
      ),
    );
  }
}
