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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              IconWidget(
                icon: shortcut?.icon,
                color: shortcut?.highlight == null
                    ? null
                    : Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size48),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                text: shortcut?.title ?? "",
                style: Style.paragraph,
                color: shortcut?.highlight == null
                    ? null : Theme.of(context).colorScheme.onPrimary,
              ),
              const SpacingWidget(LayoutSize.size8),
              const IconWidget(
                icon: Icons.arrow_forward,
                size: 10,
                borderless: true,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }
}
