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
      super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        arrowed: true,
        onPressed: onPressed,
        ready: true,
        child: content(context));
  }

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ButtonWidget(
              enabled: true,
              icon: icon,
              type: ButtonType.icon,
              onPressed: onPressed),
          const SpacingWidget(LayoutSize.size16),
          Flexible(
            // Wrap the Column with Flexible
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  style: Style.subtitle,
                ),
                if (subtitle.isNotEmpty) ...[
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                    text: subtitle,
                    style: Style.caption,
                    align: TextAlign.start,
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
