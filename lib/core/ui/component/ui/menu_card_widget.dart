import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

class MenuCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onPressed;

  const MenuCardWidget(
      {required this.icon,
      required this.title,
      required this.subtitle,
      this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      arrowed: true,
      child: content(context),
      onPressed: onPressed,
      ready: true,
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
                  icon: icon,
                  type: ButtonType.icon,
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
                  alignment: WrapAlignment.start,
                  children: [
                    TextWidget(
                      text: title,
                      style: Style.subtitle,
                    ),
                  ],
                ),
                const SpacingWidget(LayoutSize.size16),
                Wrap(
                  children: [
                    TextWidget(
                      text: subtitle,
                      style: Style.caption,
                      align: TextAlign.start,
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
