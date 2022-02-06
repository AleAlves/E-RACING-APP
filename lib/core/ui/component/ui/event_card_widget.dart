import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'bound_widget.dart';
import 'class_collection_widget.dart';

class EventCardWidget extends StatelessWidget {
  final EventModel? event;
  final IconData? icon;
  final Color? color;
  final TextAlign align;
  final VoidCallback? onPressed;

  const EventCardWidget(
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
      child: content(),
      onPressed: onPressed,
      ready: true,
    );
  }

  Widget content() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.circle,
                color: _getStatusColor(event?.state),
              ),
            ),
            const BoundWidget(BoundType.size16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: event?.title ?? event?.races?.first?.title ?? '',
                    style: Style.subtitle,
                    align: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClassCollectionWidget(
                    onPressed: (w) {},
                    classes: event?.classes,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _getType(event?.type),
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [Icon(Icons.chevron_right)],
        )
      ],
    );
  }

  Color _getStatusColor(EventState? state) {
    switch (state) {
      case EventState.idle:
        return const Color(0xFFF17F28);
      case EventState.ongoing:
        return const Color(0xFF1AA01C);
      case EventState.finished:
        return const Color(0xFFA01A1A);
      default:
        return const Color(0xFFA01A1A);
    }
  }

  Widget _getType(EventType? state) {
    switch (state) {
      case EventType.championship:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const BoundWidget(BoundType.size8),
            const TextWidget(
              text: "Championship",
              style: Style.description,
              align: TextAlign.start,
            )
          ],
        );
      case EventType.race:
        return Row(
          children: [
            Icon(icon),
            const BoundWidget(BoundType.size8),
            const TextWidget(
              text: "Race",
              style: Style.description,
              align: TextAlign.start,
            )
          ],
        );
      default:
        return Container();
    }
  }
}
