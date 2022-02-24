import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/picture_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/tag_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeagueCardWidget extends StatelessWidget {
  final String? label;
  final String? emblem;
  final int? members;
  final int? capacity;
  final TextAlign align;
  final List<TagModel?>? tags;
  final List<String?>? leagueTags;
  final VoidCallback? onPressed;

  const LeagueCardWidget(
      {this.label,
      this.emblem,
      required this.capacity,
      required this.members,
      this.tags,
      this.leagueTags,
      this.onPressed,
      this.align = TextAlign.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.only(left: 4, right: 8, bottom: 8),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
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
              const SpacingWidget(LayoutSize.size4),
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
                    const SpacingWidget(LayoutSize.size4),
                    Row(
                      children: [
                        const SpacingWidget(LayoutSize.size4),
                        const Icon(
                          Icons.groups,
                        ),
                        const SpacingWidget(LayoutSize.size8),
                        TextWidget(
                          text: "${members.toString()}/$capacity",
                          style: Style.subtitle,
                          align: TextAlign.start,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
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
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.onBackground,
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
