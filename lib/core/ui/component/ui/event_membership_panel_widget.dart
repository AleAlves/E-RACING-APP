import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/swtich_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventMembershipPanelWidget extends StatelessWidget {
  final EventModel? event;
  final Function() onToogle;
  final double minWidth;

  const EventMembershipPanelWidget(
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
      ],
    );
  }

  Widget toogleSubscriptions() {
    return Column(
      children: [
        Row(
          children: const [
            Icon(Icons.verified),
            SpacingWidget(LayoutSize.size8),
            TextWidget(
              text: "Members Only",
              style: Style.subtitle,
              align: TextAlign.left,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size16),
        SwitchWidget(
          enabled: event?.membersOnly,
          onPressed: (value) {
            onToogle.call();
          },
          negativeLabel: "Disabled",
          positiveLabel: "Enabled",
        ),
      ],
    );
  }
}
