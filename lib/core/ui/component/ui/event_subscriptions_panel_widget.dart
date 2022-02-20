import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/swtich_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventSubscriptionsPanelWidget extends StatelessWidget {
  final EventModel? event;
  final Function() onToogle;
  final double minWidth;

  const EventSubscriptionsPanelWidget(
      {Key? key,
      required this.event,
      required this.onToogle,
      this.minWidth = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) => raceList(context);

  Widget raceList(BuildContext context) {
    return Column(
      children: [
        toogleSubscriptions(),
        const SpacingWidget(LayoutSize.size8),
      ],
    );
  }

  Widget toogleSubscriptions() {
    return Column(
      children: [
        Row(
          children: const [
            Icon(Icons.assignment_ind),
            SpacingWidget(LayoutSize.size8),
            TextWidget(
              text: "Subscriptions",
              style: Style.subtitle,
              align: TextAlign.left,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size16),
        SwitchWidget(
          enabled: event?.joinable,
          onPressed: (value) {
            onToogle.call();
          },
          negativeLabel: "Disabled",
          positiveLabel: "Enabled",
        )
      ],
    );
  }
}
