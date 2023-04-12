import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../model/media_model.dart';
import 'banner_widget.dart';

class LeagueCardSmallWidget extends StatelessWidget {
  final String? label;
  final String? emblem;
  final VoidCallback? onPressed;

  const LeagueCardSmallWidget(
      {this.label, this.emblem, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardWidget(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: header(),
          ready: label != null,
        ),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget header() {
    return Column(
      children: [
        BannerWidget(
          media: MediaModel(emblem ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: titleWidget(),
        ),
      ],
    );
  }

  Widget titleWidget() {
    return Row(
      children: [
        Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                text: label,
                style: Style.title,
                align: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
