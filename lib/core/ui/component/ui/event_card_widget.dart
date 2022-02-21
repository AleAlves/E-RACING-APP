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
            progress(context),
            const SpacingWidget(LayoutSize.size24),
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
                  drivers(),
                  const SpacingWidget(LayoutSize.size4),
                  subscriptionsStatus(context)
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

  Widget progress(BuildContext context) {
    Icon idle = const Icon(
      Icons.circle,
      size: 18,
      color: Colors.transparent,
    );
    Icon onGoing = const Icon(
      Icons.circle,
      size: 18,
      color: Colors.transparent,
    );
    Icon finished = const Icon(
      Icons.circle,
      size: 18,
      color: Colors.transparent,
    );
    var track = Theme.of(context).colorScheme.secondary;

    switch (event?.state) {
      case EventState.idle:
        idle = Icon(
          Icons.circle,
          color: track,
          size: 18,
        );
        break;
      case EventState.ongoing:
        idle = Icon(
          Icons.circle,
          color: track,
          size: 18,
        );
        onGoing = Icon(
          Icons.circle,
          color: track,
          size: 18,
        );
        break;
      case EventState.finished:
        idle = Icon(
          Icons.circle,
          color: track,
          size: 18,
        );
        onGoing = Icon(
          Icons.circle,
          color: track,
          size: 18,
        );
        finished = Icon(
          Icons.circle,
          color: track,
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
          Stack(
            children: [
              idle,
              Icon(Icons.radio_button_unchecked,
                  size: 18, color: Theme.of(context).colorScheme.primary),
            ],
          ),
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: 5,
              height: 25),
          Stack(
            children: [
              onGoing,
              Icon(Icons.radio_button_unchecked,
                  size: 18, color: Theme.of(context).colorScheme.primary),
            ],
          ),
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: 5,
              height: 25),
          Stack(
            children: [
              finished,
              Icon(Icons.radio_button_unchecked,
                  size: 18, color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ],
      ),
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
      entries += element?.drivers?.length ?? 0;
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

  Widget subscriptionsStatus(BuildContext context) {
    return event?.joinable == true
        ? Row(
            children: [
              Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
              const SpacingWidget(LayoutSize.size8),
              const TextWidget(
                text: "Drivers wanted",
                style: Style.description,
                align: TextAlign.start,
              ),
              const SpacingWidget(LayoutSize.size8),
              event?.membersOnly == true ? membership(context) : Container()
            ],
          )
        : Container();
  }

  Widget membership(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.verified,
          color: Colors.blueAccent,
        ),
        SpacingWidget(LayoutSize.size8),
        TextWidget(
          text: 'Members only',
          style: Style.description,
          align: TextAlign.start,
        ),
      ],
    );
  }
}
