import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

class LeaguesCardWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const LeaguesCardWidget({this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: content(context),
      onPressed: onPressed,
      ready: true,
      arrowed: true,
    );
  }

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4, left: 8),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Row(
            children: [
              ButtonWidget(
                  enabled: true,
                  icon: Icons.emoji_events,
                  type: ButtonType.iconButton,
                  onPressed: onPressed),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: const [
                    TextWidget(
                      text: "Community",
                      style: Style.subtitle,
                    ),
                  ],
                ),
                const SpacingWidget(LayoutSize.size16),
                Wrap(
                  children: const [
                    TextWidget(
                      text: "Join a group and start racing",
                      style: Style.paragraph,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
