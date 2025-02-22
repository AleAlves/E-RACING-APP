import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/chip_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_step_progress_indicator_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/tag_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../model/tag_model.dart';
import 'class_collection_widget.dart';
import 'icon_widget.dart';
import 'spacing_widget.dart';

class EventCardWidget extends StatelessWidget {
  final EventModel? event;
  final IconData? icon;
  final Color? color;
  final TextAlign align;
  final List<TagModel?>? tags;
  final VoidCallback? onPressed;

  const EventCardWidget(
      {required this.icon,
      required this.color,
      required this.event,
      this.tags,
      this.onPressed,
      this.align = TextAlign.center,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      childLeft: EventStepProgressIndicatorWidget(
        state: event?.state,
        orientation: StatusOrientation.vertical,
      ),
      arrowed: true,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      ready: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: content(context),
      ),
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
                    text: event?.info?.title ?? event?.races?.first?.title ?? '',
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
              _getType(event?.type, context),
              const SpacingWidget(LayoutSize.size8),
              drivers(context),
              const SpacingWidget(LayoutSize.size8),
              eventStatusWidget(event?.state, context),
              const SpacingWidget(LayoutSize.size8),
              tagsWidget(),
              const SpacingWidget(LayoutSize.size8),
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
      case EventState.draft:
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

  Widget _getType(EventType? state, BuildContext context) {
    switch (state) {
      case EventType.championship:
        return Row(
          children: [
            IconWidget(icon: icon),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(
                text: "Championship",
                style: Style.caption,
                align: TextAlign.start)
          ],
        );
      case EventType.race:
        return Row(
          children: [
            IconWidget(icon: icon),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(
                text: "Race", style: Style.caption, align: TextAlign.start)
          ],
        );
      default:
        return Container();
    }
  }

  Widget drivers(BuildContext context) {
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
            text: '$entries/$max', style: Style.caption, align: TextAlign.start)
      ],
    );
  }

  Widget subscriptionsStatus(BuildContext context) {
    return event?.info?.isJoinable == true &&
            event?.state != EventState.finished
        ? Row(
            children: [
              ChipWidget(
                textColor: Theme.of(context).colorScheme.onSecondary,
                color: Theme.of(context).colorScheme.secondary,
                text: 'Drivers wanted',
              ),
              const SpacingWidget(LayoutSize.size4),
              event?.info?.isForMembersOnly == true
                  ? membership(context)
                  : Container()
            ],
          )
        : Container();
  }

  Widget membership(BuildContext context) {
    return Row(
      children: [
        ChipWidget(
          text: 'Members only',
          textColor: Theme.of(context).colorScheme.onSecondary,
          color: Theme.of(context).colorScheme.secondary,
        )
      ],
    );
  }

  Widget eventStatusWidget(EventState? state, BuildContext context) {
    var color;
    var status;
    switch (state) {
      case EventState.draft:
        color = Colors.grey;
        status = "Draft";
        break;
      case EventState.ready:
        color = Colors.amber;
        status = "Ready";
        break;
      case EventState.ongoing:
        color = Colors.green;
        status = "On going";
        break;
      case EventState.finished:
        color = Colors.red;
        status = "Finished";
        break;
      case null:
        break;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconWidget(
              icon: Icons.circle,
              color: color,
            ),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(text: status, style: Style.caption)
          ],
        ),
        const SpacingWidget(LayoutSize.size8),
        Row(
          children: [subscriptionsStatus(context)],
        )
      ],
    );
  }

  Widget tagsWidget() {
    return event?.info?.tags?.isEmpty == true
        ? Container()
        : TagCollectionWidget(
            tagIds: event?.info?.tags,
            tags: tags,
            singleLined: true,
          );
  }
}
