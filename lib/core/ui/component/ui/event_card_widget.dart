import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import 'bound_widget.dart';

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
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: CardWidget(
        ready: true,
        child: InkWell(
          splashColor: ERcaingApp.color.shade50,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: content(),
          ),
        ),
      ),
    );
  }

  Widget content() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.circle,
                  color: _getStatusColor(event?.state),
                ),
              ),
            ),
            const BoundWidget(BoundType.medium),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(icon),
                    ),
                    color: color),
              ),
            ),
          ],
        ),
        const BoundWidget(BoundType.medium),
        Expanded(
          child: Column(
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
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  spacing: 5.0,
                  children: event!.classes!
                      .map((item) {
                        return Row(
                          children: [
                            const Icon(
                              Icons.drive_eta,
                              size: 16.0,
                            ),
                            const BoundWidget(BoundType.small),
                            TextWidget(
                              text: item?.name ?? '',
                              style: Style.description,
                              align: TextAlign.start,
                            ),
                          ],
                        );
                      })
                      .toList()
                      .cast<Widget>(),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
        return const Color(0xFFC7C7C7);
    }
  }
}
