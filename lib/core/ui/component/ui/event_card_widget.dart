import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'spacing_widget.dart';
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
      markColor: _getTypeColor(),
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
            progress(context),
            const SpacingWidget(LayoutSize.size8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  _getType(event?.type),
                  const SpacingWidget(LayoutSize.size4),
                  drivers()
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
                  color: _getTypeColor(),
                ),
                child:Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.background,
                  size: 20.0,
                ),
              )
            ]),
      ],
    );
  }

  Widget progress(BuildContext context) {
    late Icon idle;
    late Icon onGoing;
    late Icon finished;

    switch (event?.state) {
      case EventState.idle:
        idle = Icon(
          Icons.circle,
          color: _getStatus()?.first,
          size: 18,
        );
        onGoing = Icon(
          Icons.radio_button_off,
          color: Theme.of(context).colorScheme.primary,
          size: 18,
        );
        finished = Icon(
          Icons.radio_button_off,
          color: Theme.of(context).colorScheme.primary,
          size: 18,
        );
        break;
      case EventState.ongoing:
        idle = const Icon(
          Icons.circle,
          size: 18,
        );
        onGoing = Icon(
          Icons.circle,
          color: _getStatus()?.first,
          size: 18,
        );
        finished = Icon(
          Icons.radio_button_off,
          color: Theme.of(context).colorScheme.primary,
          size: 18,
        );
        break;
      case EventState.finished:
        idle = const Icon(
          Icons.circle,
          size: 18,
        );
        onGoing = const Icon(
          Icons.circle,
          size: 18,
        );
        finished = Icon(
          Icons.circle,
          color: _getStatus()?.first,
          size: 18,
        );
        break;
      default:
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          idle,
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: 5,
              height: 15),
          onGoing,
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: 5,
              height: 15),
          finished,
        ],
      ),
    );
  }

  Pair<Color, String>? _getStatus() {
    switch (event?.state) {
      case EventState.idle:
        return Pair(const Color(0xFFF17F28), "In preparation");
      case EventState.ongoing:
        return Pair(const Color(0xFF1AA01C), "On going");
      case EventState.finished:
        return Pair(const Color(0xFFA01A1A), "Finished");
      default:
        return Pair(const Color(0xFF294CA5), "unknow");
    }
  }

  Color _getTypeColor() {
    switch (event?.type) {
      case EventType.championship:
        return Colors.green;
      case EventType.race:
        return Colors.blueAccent;
      default:
        return Colors.red;
    }
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
              style: Style.description,
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
              style: Style.description,
              align: TextAlign.start,
            )
          ],
        );
      default:
        return Container();
    }
  }

  Widget drivers() {
    var max = 0;
    var entries = 0;

    event?.classes?.forEach((element) {
      max += element?.maxEntries ?? 0;
      entries += element?.attenders?.length ?? 0;
    });

    return Row(
      children: [
        const Icon(Icons.sports_motorsports),
        const SpacingWidget(LayoutSize.size8),
        TextWidget(
          text: '$entries/$max',
          style: Style.description,
          align: TextAlign.start,
        ),
      ],
    );
  }
}
