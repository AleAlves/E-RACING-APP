import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import 'card_widget.dart';

class ShortcutWidget extends StatelessWidget {
  final Function(ShortcutModel?) onPressed;
  final ShortcutModel? shortcut;

  const ShortcutWidget(
      {required this.onPressed, required this.shortcut, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return normal(context);
  }

  Widget normal(BuildContext context) {
    return CardWidget(
      color: shortcut?.highlight == null
          ? null
          : Theme.of(context).colorScheme.primary,
      onPressed: () {
        onPressed.call(shortcut);
      },
      ready: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              IconWidget(
                size: 48,
                icon: shortcut?.icon,
                color: shortcut?.highlight == null
                    ? null
                    : Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SpacingWidget(LayoutSize.size8),
              TextWidget(
                text: shortcut?.title ?? "",
                style: Style.subtitle,
                color: shortcut?.highlight == null
                    ? null
                    : Theme.of(context).colorScheme.onPrimary,
              ),
              const SpacingWidget(LayoutSize.size8),
              IconWidget(
                icon: Icons.arrow_forward,
                size: 12,
                borderless: true,
                color: shortcut?.highlight == null
                    ? null
                    : Theme.of(context).colorScheme.onPrimary,
              )
            ],
          ),
          const SpacingWidget(LayoutSize.size8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(
              text: shortcut?.subtitle ?? "",
              style: Style.caption,
              align: TextAlign.start,
              color: shortcut?.highlight == null
                  ? null
                  : Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }
}
