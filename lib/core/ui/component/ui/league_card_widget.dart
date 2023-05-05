import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/tag_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import 'icon_widget.dart';

class LeagueCardWidget extends StatelessWidget {
  final String? label;
  final int? members;
  final int? capacity;
  final bool hasMembership;
  final TextAlign align;
  final List<TagModel?>? tags;
  final List<String?>? leagueTags;
  final VoidCallback? onPressed;

  const LeagueCardWidget(
      {this.label,
      required this.capacity,
      required this.members,
      required this.hasMembership,
      this.tags,
      this.leagueTags,
      this.onPressed,
      this.align = TextAlign.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardWidget(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: header(),
          ready: leagueTags != null,
        ),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget header() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: description(),
        ),
      ],
    );
  }

  Widget description() {
    return Column(
      children: [
        Column(
          children: [
            titleWidget(),
            membersWidget(),
            membershipWidget(),
            tagsWidget(),
          ],
        ),
      ],
    );
  }

  Widget titleWidget() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              TextWidget(
                text: label,
                style: Style.title,
                align: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget membersWidget() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const SpacingWidget(LayoutSize.size4),
          const IconWidget(
            icon: Icons.groups,
            borderless: true,
          ),
          const SpacingWidget(LayoutSize.size8),
          TextWidget(
            text: "${members.toString()}/$capacity",
            style: Style.paragraph,
            align: TextAlign.start,
          )
        ],
      ),
    );
  }

  Widget membershipWidget() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: const [
          SpacingWidget(LayoutSize.size4),
          IconWidget(
            icon: Icons.workspace_premium,
            borderless: true,
          ),
          SpacingWidget(LayoutSize.size8),
          TextWidget(
            text: "Member",
            style: Style.caption,
          )
        ],
      ),
    );
  }

  Widget tagsWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: TagCollectionWidget(
        tagIds: leagueTags,
        tags: tags,
        singleLined: true,
      ),
    );
  }
}
