import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
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
    return SizedBox(
      height: 100,
      width: 150,
      child: shortcut?.highlight == true ? highlighted(context) : normal(),
    );
  }

  Widget normal() {
    return CardWidget(
      onPressed: () {
        onPressed.call(shortcut);
      },
      ready: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(shortcut?.icon),
          const SpacingWidget(LayoutSize.size16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                text: shortcut?.title ?? "",
                style: Style.description,
              ),
              const SpacingWidget(LayoutSize.size8),
              const Icon(Icons.arrow_forward, size: 10,)
            ],
          )
        ],
      ),
    );
  }

  Widget highlighted(BuildContext context) {
    return CardWidget(
      onPressed: () {
        onPressed.call(shortcut);
      },
      ready: true,
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            shortcut?.icon,
            color: Theme.of(context).cardColor,
          ),
          const SpacingWidget(LayoutSize.size16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                text: shortcut?.title ?? "",
                style: Style.description,
                color: Theme.of(context).cardColor,
              ),
              const SpacingWidget(LayoutSize.size8),
               Icon(Icons.arrow_forward, size: 10, color: Theme.of(context).cardColor,)
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
