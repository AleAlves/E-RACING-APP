import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/tools/access_validation_extension.dart';
import 'package:e_racing_app/core/tools/date_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'button_widget.dart';
import 'expanded_widget.dart';

class EventAdminPanel extends StatelessWidget {
  final EventModel? event;
  final Function() onToogle;

  const EventAdminPanel({Key? key, required this.event, required this.onToogle})
      : super(key: key);

  @override
  Widget build(BuildContext context) => raceList(context);

  Widget raceList(BuildContext context) {
    return Column(
      children: [
        toogleSubscriptions(),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget toogleSubscriptions() {
    var indexStatus = event?.joinable == true ? 0 : 1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const TextWidget(
            text: "Subscriptions",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
          const SpacingWidget(LayoutSize.size16),
          ToggleSwitch(
            initialLabelIndex: indexStatus,
            totalSwitches: 2,
            labels: const ['Open', 'Closed'],
            radiusStyle: true,
            onToggle: (index) {
              if (index != indexStatus) {
                onToogle.call();
              }
            },
          ),
        ],
      ),
    );
  }

}
