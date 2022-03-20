import 'package:e_racing_app/core/ext/dialog_extension.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/swtich_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventSubscriptionsPanelWidget extends StatelessWidget {
  final EventModel? event;
  final Function() onToogle;
  final Function() onToogleMembership;
  final double minWidth;

  const EventSubscriptionsPanelWidget(
      {Key? key,
      required this.event,
      required this.onToogle,
      required this.onToogleMembership,
      this.minWidth = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) => raceList(context);

  Widget raceList(BuildContext context) {
    return Column(
      children: [
        toogleSubscriptions(context),
      ],
    );
  }

  Widget toogleSubscriptions(BuildContext context) {
    var isOnGoing = event?.state == EventState.ongoing;
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
          enabled: isOnGoing ? event?.joinable : false,
          onPressed: (value) {
            if(isOnGoing){
              onToogle.call();
            }
            else{
              showAlertExt(context: context, message: 'Event must be on going to allow subscriptions', );
            }
          },
          negativeLabel: "Disabled",
          positiveLabel: "Enabled",
        ),
        toogleMembersOnly(),
      ],
    );
  }

  Widget toogleMembersOnly() {
    return Column(
      children: [
        SwitchWidget(
          enabled: event?.membersOnly,
          onPressed: (value) {
            onToogleMembership.call();
          },
          negativeLabel: "For anyone",
          positiveLabel: "Members Only",
        ),
      ],
    );
  }
}
