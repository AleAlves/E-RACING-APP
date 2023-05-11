import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/material.dart';

import 'menu_card_widget.dart';

class ShortcutWidget extends StatelessWidget {
  final Function(ShortcutModel?) onPressed;
  final ShortcutModel shortcut;

  const ShortcutWidget(
      {required this.onPressed, required this.shortcut, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return normal(context);
  }

  Widget normal(BuildContext context) {
    return MenuCardWidget(
        icon: shortcut.icon,
        title: shortcut.title,
        subtitle: shortcut.subtitle,
        onPressed: () {
          onPressed.call(shortcut);
        });
  }

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }
}
