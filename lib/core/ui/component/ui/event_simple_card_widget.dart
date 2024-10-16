import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../ext/event_iconography_extension.dart';
import 'class_collection_widget.dart';
import 'spacing_widget.dart';

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
      super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        borderColor: getColor(event?.type, context),
        arrowed: true,
        onPressed: onPressed,
        ready: true,
        child: content(context));
  }

  Widget content(BuildContext context) {
    return Row(
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
                style: Style.subtitle,
                align: TextAlign.start,
              ),
              const SpacingWidget(LayoutSize.size8),
              ClassCollectionWidget(
                onPressed: (w) {},
                classes: event?.classes,
              ),
              _getType(event?.type, context),
              const SpacingWidget(LayoutSize.size16),
            ],
          ),
        )
      ],
    );
  }

  Widget _getType(EventType? state, BuildContext context) {
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
            TextWidget(
              text: "Race",
              style: Style.paragraph,
              align: TextAlign.start,
              color: Theme.of(context).colorScheme.outline,
            )
          ],
        );
      default:
        return Container();
    }
  }
}
