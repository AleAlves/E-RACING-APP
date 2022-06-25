import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import 'spacing_widget.dart';
import 'class_collection_widget.dart';

class EventSimpleCardWidget extends StatelessWidget {
  final EventModel? event;
  final IconData? icon;
  final Color? color;
  final TextAlign align;
  final VoidCallback? onPressed;

  const EventSimpleCardWidget(
      {required this.icon,
      required this.color,
      required this.event,
      this.onPressed,
      this.align = TextAlign.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      markColor: Colors.green,
      child: content(context),
      onPressed: onPressed,
      ready: true,
    );
  }

  Widget content(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SpacingWidget(LayoutSize.size16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                    text: event?.title ?? event?.races?.first?.title ?? '',
                    style: Style.title,
                    align: TextAlign.start,
                  ),
                  const SpacingWidget(LayoutSize.size8),
                  ClassCollectionWidget(
                    onPressed: (w) {},
                    classes: event?.classes,
                  ),
                  _getType(event?.type),
                  const SpacingWidget(LayoutSize.size8),
                ],
              ),
            )
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.chevron_right,
              )
            ]),
      ],
    );
  }


  Widget _getType(EventType? state) {
    switch (state) {
      case EventType.championship:
        return Row(
          children: [
            Icon(icon),
            const SpacingWidget(LayoutSize.size8),
            const TextWidget(
              text: "Championship",
              style: Style.paragraph,
              align: TextAlign.start,
            )
          ],
        );
      case EventType.race:
        return Row(
          children: [
            Icon(icon),
            const SpacingWidget(LayoutSize.size8),
            const TextWidget(
              text: "Race",
              style: Style.paragraph,
              align: TextAlign.start,
            )
          ],
        );
      default:
        return Container();
    }
  }
}
