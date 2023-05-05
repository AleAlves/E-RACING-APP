import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/league/list/data/league_model.dart';
import 'package:flutter/material.dart';

import '../../../model/media_model.dart';
import '../../../model/pair_model.dart';
import 'banner_widget.dart';

class LeagueCardSmallWidget extends StatefulWidget {
  final List<Pair<LeagueModel?, MediaModel>?> leagues;
  final VoidCallback? onPressed;

  const LeagueCardSmallWidget(
      {required this.leagues, required this.onPressed, Key? key})
      : super(key: key);

  @override
  _LeagueCardSmallWidgetState createState() => _LeagueCardSmallWidgetState();
}

class _LeagueCardSmallWidgetState extends State<LeagueCardSmallWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return content();
  }

  Widget content() {
    var index = -1;
    return Wrap(
      children: widget.leagues
          .map((element) {
            index++;
            return cardWidget(index, element?.first);
          })
          .toList()
          .cast<Widget>(),
    );
  }

  Widget cardWidget(int index, LeagueModel? league) {
    return Column(
      children: [
        CardWidget(
          padding: EdgeInsets.zero,
          onPressed: widget.onPressed,
          child: header(index, league),
          ready: widget.leagues.isNotEmpty == true,
        ),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget header(int index, LeagueModel? league) {
    return Column(
      children: [
        BannerWidget(
          media: widget.leagues[index]?.second,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: titleWidget(league),
        ),
      ],
    );
  }

  Widget titleWidget(LeagueModel? league) {
    return Row(
      children: [
        Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                text: league?.name,
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
