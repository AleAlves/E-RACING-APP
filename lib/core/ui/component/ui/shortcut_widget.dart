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
    return CardWidget(
      onPressed: () {
        onPressed.call(shortcut);
      },
      child: SizedBox(
        width: 100,
        height: 100,
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
              ],
            )
          ],
        ),
      ),
      ready: true,
    );
  }

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }
}
