import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/chip_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/status_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import 'class_collection_widget.dart';
import 'icon_widget.dart';
import 'spacing_widget.dart';

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
      childLeft: StatusWidget(
        state: event?.state,
        orientation: StatusOrientation.vertical,
      ),
      arrowed: true,
      padding: EdgeInsets.zero,
      child: content(context),
      onPressed: onPressed,
      ready: true,
    );
  }

  Widget content(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SpacingWidget(LayoutSize.size8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpacingWidget(LayoutSize.size16),
              Wrap(
                children: [
                  TextWidget(
                    text: event?.title ?? event?.races?.first?.title ?? '',
                    style: Style.subtitle,
                    align: TextAlign.start,
                  ),
                ],
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
              subscriptionsStatus(context),
              const SpacingWidget(LayoutSize.size16),
            ],
          ),
        ),
      ],
    );
  }

  Widget progress(BuildContext context) {
    Icon idle = const Icon(
      Icons.circle,
      size: 10,
      color: Colors.transparent,
    );

    Icon ready = const Icon(
      Icons.circle,
      size: 10,
      color: Colors.transparent,
    );
    Icon onGoing = const Icon(
      Icons.circle,
      size: 10,
      color: Colors.transparent,
    );
    Icon finished = const Icon(
      Icons.circle,
      size: 10,
      color: Colors.transparent,
    );
    var track = Theme.of(context).focusColor;
    var bar1Width = 3.0;
    var bar2Width = 3.0;

    switch (event?.state) {
      case EventState.idle:
        idle = Icon(
          Icons.circle,
          color: track,
          size: 12,
        );
        break;
      case EventState.ready:
        idle = Icon(
          Icons.circle,
          color: track,
          size: 18,
        );
        ready = Icon(
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
        ready = Icon(
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
        ready = Icon(
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
      child: Stack(
        children: [
          const IconWidget(icon: Icons.radio_button_unchecked, size: 18),
          const IconWidget(icon: Icons.radio_button_unchecked, size: 18),
          const IconWidget(icon: Icons.radio_button_unchecked, size: 18),
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: bar1Width,
              height: 15),
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: bar1Width,
              height: 15),
          Stack(
            children: [
              onGoing,
            ],
          ),
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: bar2Width,
              height: 15),
          Stack(
            children: [
              finished,
              const IconWidget(icon: Icons.radio_button_unchecked, size: 18)
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
            IconWidget(icon: icon),
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
            IconWidget(icon: icon),
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

  Widget drivers() {
    var max = 0;
    var entries = 0;

    event?.classes?.forEach((element) {
      max += element?.maxEntries ?? 0;
      entries += element?.drivers?.length ?? 0;
    });

    return Row(
      children: [
        const IconWidget(icon: Icons.sports_motorsports),
        const SpacingWidget(LayoutSize.size8),
        TextWidget(
          text: '$entries/$max',
          style: Style.paragraph,
          align: TextAlign.start,
        ),
      ],
    );
  }

  Widget subscriptionsStatus(BuildContext context) {
    return event?.joinable == true
        ? Row(
            children: [
              const ChipWidget(
                text: 'Drivers wanted',
              ),
              const SpacingWidget(LayoutSize.size4),
              event?.membersOnly == true ? membership(context) : Container()
            ],
          )
        : Container();
  }

  Widget membership(BuildContext context) {
    return Row(
      children: const [ChipWidget(text: 'Members only')],
    );
  }
}
