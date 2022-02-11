import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/picture_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/tag_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class LeagueItemWidget extends StatelessWidget {
  final String? label;
  final String? emblem;
  final TextAlign align;
  final List<TagModel?>? tags;
  final List<String?>? leagueTags;
  final VoidCallback? onPressed;

  const LeagueItemWidget(
      this.label, this.emblem, this.tags, this.leagueTags, this.onPressed,
      {this.align = TextAlign.center, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: content(context),
      ),
      ready: leagueTags != null,
    );
  }

  Widget content(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              PictureWidget(
                image: emblem,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Wrap(
                        children: [
                          TextWidget(
                            text: label ?? '',
                            style: Style.subtitle,
                            align: TextAlign.start,
                          )
                        ],
                      ),
                    ),
                    const SpacingWidget(LayoutSize.size16),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, right: 8 ,left: 8),
                      child: tagsWidget(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Icon(
                Icons.chevron_right,
                size: 24.0,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget tagsWidget() {
    return TagCollectionWidget(
      tagIds: leagueTags,
      tags: tags,
      singleLined: true,
    );
  }
}
